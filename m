Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45352AC72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351247AbiEQUGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352901AbiEQUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:06:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A291D12A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:06:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 4so97723ljw.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mvbsZxesHLOG63azhAKVTp/LJfiWJZzs4O+J5BDoyUM=;
        b=ODsUmgzH2UowvsEapJxkiqWDkFIDzv3W31CBDdpz/yC6PKm7O/2B4zLG9QtCt6MAcA
         t71NTTw7Qy0Cr+tcZ6Mgq/+a5MVKWLRvjRXvUgR5FR3/7DWlBkQ262dP8Bxc2Cqeip6Y
         ZsDdwO0gMwrIjLgFAqX0GwMbWgm2N1/v/GfUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mvbsZxesHLOG63azhAKVTp/LJfiWJZzs4O+J5BDoyUM=;
        b=lBCmVmCL3dwTQPFTPUTEvn0ty+IFCQIGLdT6FSBrZ9BZ2V1tthnkpuXnn9Gd2XVefw
         +xJWmgQ/ZKuQilI3zPf5URIXl6U9Pp/7oca8ALovZNw0CPuIyqHh9I+c32xa4M3XxVy0
         hI4nZ6w/LUsOLxjUEJ1GKrygBUCZKdk4I0yDOF7t97bPUvqONC3zxDFmcSa6Yi3NgGUX
         wd306nhQxYQ+AzEz4uoI/e6i5jCeDVLsjeFDbNosEaZibakMEzZ4hQrBLonUL+chXXTs
         HPUch67iXBjqHyjtvzdeu6Y0ecTjM+RUzU8uOq4T/cZDr3W3I9YDbrdvoqLfDWS1PXd8
         aC/A==
X-Gm-Message-State: AOAM533MRUuJRzlVmMJ2cC2yvJ/B1xSZwWEHok0z5xpbWZUrgofOCTyF
        qPNyv4oZV8Vpck7BussitweIfEH9XXPU0ZPFlxZtrIAUIw4=
X-Google-Smtp-Source: ABdhPJzcqorTOfRCis7RSf9b+7pvh+4jthqZQSdCXdNt0X8KbC2Rx0G8lw6zDck9C8VRzVof3upLg55ZcriE0z1b6Bg=
X-Received: by 2002:a2e:5309:0:b0:253:af56:4fc0 with SMTP id
 h9-20020a2e5309000000b00253af564fc0mr4585825ljb.341.1652817966524; Tue, 17
 May 2022 13:06:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 May 2022 13:06:05 -0700
MIME-Version: 1.0
In-Reply-To: <ceb32b66-1341-d54f-a60a-5c342119c784@linaro.org>
References: <20220517193307.3034602-1-swboyd@chromium.org> <ceb32b66-1341-d54f-a60a-5c342119c784@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 17 May 2022 13:06:05 -0700
Message-ID: <CAE-0n50rUW7Lqk4CwfSUgKYEJzwjXuVohAnbj9uKA=kEkXikyw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
To:     Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-05-17 12:51:34)
> On 5/17/22 2:33 PM, Stephen Boyd wrote:
> > We don't use this carveout on trogdor boards, and having it defined in
> > the sc7180 SoC file causes an overlap message to be printed at boot.
> >
> >   OF: reserved mem: OVERLAP DETECTED!
> >   memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)
> >
> > Delete the node in the trogdor dtsi file to fix the overlap problem and
> > remove the error message.'
>
> Is the mpss_mem node (which defines 0x86000000-0x8ec00000) correct?

I think it is. Modem is working for me.

>
> You're right, we don't use that memory on Chrome OS, but I just
> wondered whether the other node might also have a problem.

What sort of problem are you thinking about?

>
> I don't actually know...  Bjorn, do you?
>
