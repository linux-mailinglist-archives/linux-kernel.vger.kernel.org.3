Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC19B57BD42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiGTRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGTRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:54:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF985D0F3;
        Wed, 20 Jul 2022 10:54:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso2259238wmq.1;
        Wed, 20 Jul 2022 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nvBmcuzvSurejSZdYSe5kOht66040DYtWGbKekxuKaE=;
        b=CCgD980K35ClV34zACGAPCEkcZPbx6s5IHZQMEp9ADUJFFsaIunseILJhZ8XUuYX3c
         uspOQMinN1OaJdSRO7BrYBM64BWh6HvX6lMlB5fBmiQvfd9ZD2BGXSipgcx8b8qpy+dF
         DltEfqGBx2e17cPKObE/1TXjxsh54yN++MFVx9DM1HWeNJ63Obl9raHNyVt2Ry9wFMSv
         udSYaYePpBv7RE8grtk8D2ENRQVYb4bt3xaZ6ItaQU5aREyqUBhu3BWAq56OWMZjCsOo
         k3XqgBgLnP0Q7b9kxBqTFL+wrcBmfr0pe1V2DevfwLX191Xg3awsW/utcCS8YQRnU6xC
         u5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nvBmcuzvSurejSZdYSe5kOht66040DYtWGbKekxuKaE=;
        b=qCZucCPFnwBhmeZDAiqhZldjmBX+4RWs3pArWbkTnDGpChcNvVzMSdVuNGpWGDU2nu
         XFc7EwN5DzbDmmDO6WfCBD74D4fWhmOUdheuH26Yii/piZ6unj+JFHXqnRwCfFYQHfci
         JpEITfxOQSe+M4Tw0P/0x5nyORQtnFOUOS7VtsEqUDingI8x48FVVCx+QXLQ0907AccT
         xVG8zodCACvAFnfX1TwLA5L7/W7bw2IHwO6ToI9fyJFj4VgtpKdAv8VQjQOIHAIWO/8v
         1VbVKEx+9oDbwAXQnolN41+9OhxmzXZ4oKh/CYDgGxA/adK6S2gYCXIFohN7gatePeck
         XzAw==
X-Gm-Message-State: AJIora/7ayTpc+Xeu8I3nm/vQ4/vwhpry09kb5/3ZymILx1FBQ0A6/hZ
        V77Y1MdDVGLlQnpviPScPGY=
X-Google-Smtp-Source: AGRyM1u8T+zYmxSaSUGuaHlC+Yw3jW3KePCz4cspfcEmn36fKvTaoLWxmhFqjCU1othrnDDK5c1V9Q==
X-Received: by 2002:a05:600c:3b24:b0:3a3:1fa6:77d with SMTP id m36-20020a05600c3b2400b003a31fa6077dmr4869273wms.3.1658339687195;
        Wed, 20 Jul 2022 10:54:47 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id q19-20020a7bce93000000b003a31ca9dfb6sm3935248wmj.32.2022.07.20.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:54:46 -0700 (PDT)
Date:   Wed, 20 Jul 2022 19:54:44 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Message-ID: <20220720175444.GA10744@elementary>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
 <20220720173656.GA3725@elementary>
 <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Jul 20, 2022 at 08:45:55PM +0300, Nikolai Kondrashov wrote:
> On 7/20/22 20:36, José Expósito wrote:
> > I don't know about any broken device handled by the driver, so there is
> > no need to add new code yet :)
> > I'll try to keep an eye on DIGImend's issue tracker now that the code
> > present in the upstream kernel is being released by many distros.
> 
> If you have the time, backporting your changes to digimend-kernel-drivers
> would get you feedback much faster :)
> 
> I can do a release once we get the code in.

I already opened a PR a few months ago:
https://github.com/DIGImend/digimend-kernel-drivers/pull/598

But more code has been merged since then. I'll try to backport the
latest changes this weekend and ping you on GitHub once it is
ready for review again.

Best wishes,
Jose
