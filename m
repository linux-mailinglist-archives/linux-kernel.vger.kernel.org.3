Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCD47CADE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhLVBmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhLVBmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:42:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E24C061574;
        Tue, 21 Dec 2021 17:42:16 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id de30so935471qkb.0;
        Tue, 21 Dec 2021 17:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCN9MbBbsSLQre2+oydcyhTYZYw9WIy7kClZtsQdVGI=;
        b=Hodil8n7Mt8VfemZoZNHNMvamNcrtiYAv02Ce8X4y5Pxv0KHIIS4S6OUmNqR6VKb/I
         2LvR5VCXlnjf/AuA1RVpV/PP+6zIP1znHhVk84y+/7LhCHBd2xcKYqmwBgZyF4N0nYEc
         mE10s6w7CgRCvZ16BzPQcs9k0rUOhLG3P8bH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCN9MbBbsSLQre2+oydcyhTYZYw9WIy7kClZtsQdVGI=;
        b=H+EpOmkZPXO3k/71/klRWyEyPzghy3nA71o9Jq1g9hs/ev1+UT35g9+PnUo2/GPDJg
         fLk3J/IRuYIXF0TJK03eXNk16b0A7knNSwKX8hAAFHvaRMO+mz44YL5CpoP4107tSe0e
         AJuWSsixIym1zm1Bxy4wEVgCGF2f/dF2eqbfv4rbTJTl8hdPw6ZD40PbHdGRHE4AIs0j
         IZp6e3CHwmojfMTVL+YIPEtC1jYDbLgI+gv2S1GD5SDAw98nJXfyTQhf+Ug1oLZyGEdN
         aMwFgVwoHL0UXDK6ns4SCjo7lTLobeoLVMsoW+uyr95fyk3WIpfrYhNxti/yCN8l3e7/
         DzPQ==
X-Gm-Message-State: AOAM530VPU6wC+4lCI1HWHYEz9sWaOAFmzvYleCQEqpqkwTJM5dzxQ3F
        cjjL8T7nKDdKdm5GK3miz/i0zs39Tjoj4vKAwi0=
X-Google-Smtp-Source: ABdhPJwmJ9i4jMsvi4V6fz7AloWq/zVOcLqmADCy9D0Hm4pUYF7rzmNHvE+3eh7PMM5aKtpxu3YC39924vWtAqxG3uU=
X-Received: by 2002:a37:94c2:: with SMTP id w185mr746817qkd.666.1640137335360;
 Tue, 21 Dec 2021 17:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20211207094923.422422-1-howard.chiu@quantatw.com>
 <CACPK8XddhFn3PreJM3D=djkREgqGD7yZhS7YoqxxXsNfhZpLhQ@mail.gmail.com> <YcH2MSByPLAvw5mI@heinlein>
In-Reply-To: <YcH2MSByPLAvw5mI@heinlein>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 01:42:02 +0000
Message-ID: <CACPK8XcNSO9pwJiL_-0jyCSZ5jxdY6HdU5MDReByMcRbyeA6yQ@mail.gmail.com>
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Howard Chiu <howard10703049@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>,
        Howard Chiu <howard.chiu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 15:43, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Tue, Dec 21, 2021 at 04:37:55AM +0000, Joel Stanley wrote:
> > Hi Patrick,
> >
> > On Tue, 7 Dec 2021 at 09:52, Howard Chiu <howard10703049@gmail.com> wrote:
> > >
> > > Initial introduction of Facebook Bletchley equipped with
> > > Aspeed 2600 BMC SoC.
> > >
> > > Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> >
> > Are you ok for this one to go in for v5.17?
>
> Yes.
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
>
> Would also appreciate if you could apply to your Aspeed tree for OpenBMC.

Thanks. I've done both.
