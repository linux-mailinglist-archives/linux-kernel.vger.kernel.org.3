Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFEE50B2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445181AbiDVI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbiDVI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:29:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB352E5D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:27:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv16so9920346wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=u7TUP/Txry1UFuyT1GMH6MxIlNWsEqUWlVQuJ3Ycgo4=;
        b=2/I5sgtu6yek/DqrCw3fNAG0CyFOv3PlhCCCJ+GXocYogXRpOANpLUGCSLIL6TXXJL
         ncM/kLDoJ/bNF7oVzLDmvTM1U3qDOvltDLOY94qFOFrVnXCkZfDsjDwyWE2jcRPo5B1P
         ttxqJ8yX7vcodL42mKjo/d0lRMIGPiXtLb17dpL2lYUuxkj6MobpP5XnR8PmKbChBY0Z
         7zmq27Ase+2MLiNJ+AreILAY0VwbdAMekeGiuF36tHqnyXwpBeV6cqPt/OeTETRnDqrU
         +QHBEU1kHUMiZEs4+Xe8l3uwd3L6Dy+ht+n9MPLNoA7z1gb/z+BsoiCI7GOSeiqizJDX
         7PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=u7TUP/Txry1UFuyT1GMH6MxIlNWsEqUWlVQuJ3Ycgo4=;
        b=Fot+HlZpIRLrXgoDr+uH4x7J6iVVsvhRGXWPEv4v/Oz49ac2DN7QO9VU8EIRUanKxZ
         5+FUfYLxPEQ051oSXjQqp3brpL1dPDJvEFxdsxq2mqwyWYvVLGlWd4kOeJ66JjeBG4rP
         NAfq3Gandn/SzWOn60F3bY4RgmMErpgVmGwXwafeEPdQhT/6D9HXUKMLOr2+JKVktHLl
         H2GsevC1MCGBzyUxFLgY/k9Kj0deg/rk7+v4Mtigd7tt+f2Xk8HcXOqY/3pGQctDfVbB
         Ci9llsmiRMBauDSVkhMmjEkZKn2mjEDjcC8rDZkMpsDE4JudjEPGeS0OCH4WPRd4xLOP
         Y1TA==
X-Gm-Message-State: AOAM530dGXR2h5xFIGR55TpUu90saAzACkpzoaPVbcuzBczrMxFBaT75
        IVJGe2vmO0jnTGc2kgqCXbCq7A==
X-Google-Smtp-Source: ABdhPJwc7lC7iXT26SYx3VMbx1Xy9+zwh+M/Yt5wvRZ3xffC5nUuF/FW32z69itymsszmlEUC9PuCA==
X-Received: by 2002:adf:f2cb:0:b0:20a:77c2:3958 with SMTP id d11-20020adff2cb000000b0020a77c23958mr2637147wrp.589.1650616021757;
        Fri, 22 Apr 2022 01:27:01 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d6d04000000b0020a8bbbb72bsm1335208wrq.97.2022.04.22.01.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 01:27:00 -0700 (PDT)
Message-ID: <b6029a92-04f0-9ae7-291c-621f9871280b@baylibre.com>
Date:   Fri, 22 Apr 2022 10:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage
 formatters in trigger"
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
 <YmGSeVbwWtyHP/Tz@sirena.org.uk>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YmGSeVbwWtyHP/Tz@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 21/04/2022 19:20, Mark Brown wrote:
> On Thu, Apr 21, 2022 at 05:57:24PM +0200, Neil Armstrong wrote:
>> This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
>> the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68
> 
> One other thing - these should be Fixes: tags, that helps tooling figure
> out things like backports.
> 
> Also:
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Thanks, I'll think of this for the next time.

Neil
