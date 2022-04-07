Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FE4F83F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiDGPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbiDGPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:48:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04277CA0D5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:46:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q19so5262981pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kp+q9ML7Jywsrgwy6TQGYaSUuB+moeachq4LWhV6igg=;
        b=hefoP6nGQpP3n6tFd6H/gJBidYMW/2hakYiLJlLUV2wzwWwvqep+6g2uBEJU0sw/Sy
         hxjhrUtVa5AurtECklDgEjEpPeRJM8jW41FrL0OU471FMjcTCXmhWPMwcVTx1Eho74A+
         l2VwZMM3YF/J/s6bGa0mKdGL1i0TLo90SpxnaH3VcVRSdCxkJaVTs4gsACxpRx694ArE
         sWa4BVaVqZ04blrMwo2qFHQGY56IYpFA9/IDtKivnivTVCYyTr5XS4Gv9e4sYh20NQF7
         bEpLKI2EHE1LKybWHmtbnr1sCQTpGOaa/qpK1T4pZltmKPubMhc1zAbjd8bVr+4vvjZH
         1w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kp+q9ML7Jywsrgwy6TQGYaSUuB+moeachq4LWhV6igg=;
        b=xiqQE3Cy64stg9vT82Y8P8uvf/oX2aQ2plfClBEnARz66VHE5dX1jGtsnSLauBps/s
         82OCgu6xd10gtEE0Mk1dJ/BCHSqFxSHTE9+gA4tXfcGPwCHKLOr/plknIENib9aIyldi
         kpQExP6zPfGqWLrsTkFRR+2pG6yh45YlX1U16ssYehpm8qoLg+d0FK/++4dO0t/+ezGs
         89P45VoGRX/xlODxtbMfJlUrTBfffp9Ika3PvcTscrpRjXtysiSchGFtvYX34Y2phUUf
         tdsDTNOgx4oZ+rGDjSanR62EybAEqN1PrvjwhHCZC3vrwKlZNHe7e9kxf35MNuDOfDDK
         fdxw==
X-Gm-Message-State: AOAM531q9zwGRJcAFyyp62nggU/V+4y7s9dAy0Fw6c+uZUMa+3eYNUQ4
        ZQAyVId5bzgLRAr9fgf6f6k=
X-Google-Smtp-Source: ABdhPJxt5Re64SMX9kNXS2PPlitna87huotHYdm5S7iB2YXVyFqJ1QBNvBG4+Sv54aLnQKi9iXwluA==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr14877749pfu.59.1649346368636;
        Thu, 07 Apr 2022 08:46:08 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id lx13-20020a17090b4b0d00b001c9989c721esm10028459pjb.17.2022.04.07.08.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 08:46:08 -0700 (PDT)
Message-ID: <96dae189-c0ff-4054-3d00-41c3b44c2cd6@gmail.com>
Date:   Fri, 8 Apr 2022 00:46:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
 <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/08 0:09, Mark Brown wrote:
> On Thu, Apr 07, 2022 at 11:13:16PM +0900, Akihiko Odaki wrote:
> 
>> Create a jack kcontrol manually as rt5682 does not use DAPM pins
>> for jack and will not have kcontrols for them.
> 
> Why not use DAPM for the jack?  Note that normally the jack is part of
> the machine driver not the CODEC - there's no way the CODEC can know how
> it's been wired in on any given system.

It seems it is an unsual case where the codec knows the source of the 
jack. RT5682 has interrupts and registers for the jack; see e.g. 
rt5682_button_detect in sound/soc/codecs/rt5682.c for details.

Regards,
Akihiko Odaki
