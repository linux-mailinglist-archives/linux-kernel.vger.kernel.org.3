Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E044E784C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354431AbiCYPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377755AbiCYPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:53 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35728BB908
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v75so8566852oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=D+jLkCpaZNDCy/uHdMrqvNgmVKMmoKiEpprLxsWBcrk=;
        b=WBMTOJnlOcFnH70i8g1Z6BQViSEKTHEq/JyckGw+LCen6SAQFfxSLY90bsZOQGT++Q
         nPQ1kRnmegekXItS+NyN2cZnYsT4bcgYYUcAmvnTsFmmFyNWgFtPfCsf2CrfGmDnzHD7
         6GJhJIbuezWeKdL9cDaz14ZtbczF4ms9wTV7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=D+jLkCpaZNDCy/uHdMrqvNgmVKMmoKiEpprLxsWBcrk=;
        b=vqC8H4FwqHC5IABTuRvl504asqpn6XFDP0xBnDD58LfOOqpt6nDrJcDMNzLt1qoqCc
         y5yurHvlVJf5C9FTCA+kP7LBnknoRfeTsnswBltUHTLhXRPAGMHBA5XvYY+de7uu7N7l
         NzYcxVAMRBvAO9dIjQzHQJOV/6gLgKQwjdP4bOeLZECFD0umzmRPcIVC3v1SbxlqThI7
         foHfqK5BLwM0eoZLZsbkbSVM+t82y2Zxs9uHUMapmqt/BRljcldSWT6JdwfEK4Ap16Tv
         uYbHuD2s9bMvdfv0KPaHb4wAQJjNfy6psO9uMPNISZyN0026+s9hUkuwWO1HHPoeVMJ2
         RQPg==
X-Gm-Message-State: AOAM531Jfer8aRjNwRPFsxdW195BXJYfcDP8tcAL7JQb8p5ycQ6B9QBy
        Ubn59HkJmTL2wYk0F5CCUF+Sl20jkpkKKAnLJauJkQ==
X-Google-Smtp-Source: ABdhPJzHLYq1n0oMw/ZrH7LYQF2eWCeFDmwwVx7wahLFhNpTjgHMpkRd/MVfGx7ajwKra2C02IMCHnunrXRCl3BK0Bo=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr5566847oif.63.1648222833524; Fri, 25
 Mar 2022 08:40:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 10:40:33 -0500
MIME-Version: 1.0
In-Reply-To: <YjknOFMere5DG5He@robh.at.kernel.org>
References: <20220321191100.1993-1-swboyd@chromium.org> <20220321191100.1993-2-swboyd@chromium.org>
 <YjknOFMere5DG5He@robh.at.kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 10:40:33 -0500
Message-ID: <CAE-0n532uGx+VstUEt9ZC+_6Tg6_HsaJAsKn1p02Q3qV9XqEPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: chrome: Add ChromeOS fingerprint binding
To:     Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-03-21 18:32:40)
> On Mon, Mar 21, 2022 at 12:10:57PM -0700, Stephen Boyd wrote:
> > Add a binding to describe the fingerprint processor found on Chromebooks
> > with a fingerprint sensor. Previously we've been describing this with
> > the google,cros-ec-spi binding but it lacks gpio and regulator control
> > used during firmware flashing.
>
> Then 'google,cros-ec-spi' should be a fallback?

How do I describe that in the schema without causing google,cros-ec.yaml
to jump in and complain that there are unknown properties? Do I need to
combine these two schemas and then have conditional properties?
