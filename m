Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47881578618
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiGRPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGRPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:17:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B61527B17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:17:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a18-20020a05600c349200b003a30de68697so3519110wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fIeWgJkq4ADJTJssdbY8YcP7rWqEzAaP7D1xlEKvTj4=;
        b=awRdYtNS2Zyiv24INdiZICqbDqtDmWcLaeLnOKQd3penNpY/vYGRfLDfEK5Q8Vi5HL
         J+zCcVqHSBZvyzPzodMAy8m4TVb54t5GmzivIeDekMJhNYQrVfDJ1omwMyq7r0pcWmPh
         Al/UVWaXYJgr5MLirqXRAewR6upob6IhkVip/FhJqpntbk8KoLwj19NKhA5yGTGzMPMO
         syTWnQRe3HFWFmyd2qYMp1FHlkCSlYUEEw7I2dMEc8X02yz23e5ciVCz0/JqSh8NlKUf
         JdAAClVRxvhpVgw0QXH+GuWbL+GuFzA5wu6Yq0bCgRvWmkhkjYvMiohM8+3L0Mf5iuxz
         QQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fIeWgJkq4ADJTJssdbY8YcP7rWqEzAaP7D1xlEKvTj4=;
        b=OzyPEWO95f1UGBHJdUCcWIWnDvD6Ek1yNFP9QaH21kfrTFRhMgFAVXcA76avMIiz6A
         SbdAEQqeqNiCQyJUjksFWb9k7KfTii/lgxLU3HTNV7hoMiOh+3UgkLF3t9QYECtswJFg
         EUKStaZaCR7dOBrp8W/1bBfyX42Dcljhd2cxMxOlLoI5shsSc7dCPcV8/ApV62OGNcGZ
         A4VwlSxVKuoRRdJ5Q4DxOo9noXnsYaHvmUzvTWJK5cX2kBZyOpIldK/vnlC7qwYHIh7C
         3NsfGNelTXRT4iFttObqFNCJujJKncrnvmhcV7Y21OSHM+H1r+8i49isRQGJoaiXj9ru
         N36w==
X-Gm-Message-State: AJIora8A/TsHyMRIcrXuOhO6dzrlIyMEhBXB4NcUle3XVg3xTkFzjhvV
        dgQBfhGrxX6+2m35nYnPikKGT7D2uX4MbA==
X-Google-Smtp-Source: AGRyM1vDNjWwA9Q0bIP0N1CjK7w7jTUsJ/pcKL3y7r/RaZ0lkzMqNlp6GVH1rCljYn1HEHatFfGobQ==
X-Received: by 2002:a05:600c:3ac4:b0:3a3:19c5:7cb2 with SMTP id d4-20020a05600c3ac400b003a319c57cb2mr6104107wms.63.1658157436961;
        Mon, 18 Jul 2022 08:17:16 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b003a32167b8d4sm128487wmb.13.2022.07.18.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:17:16 -0700 (PDT)
Date:   Mon, 18 Jul 2022 16:17:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YtV5eoSKj8Y0BYsa@google.com>
References: <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
 <Yr1iweMUl+EUY+Q6@google.com>
 <YtHF2giNT1gG1wge@smile.fi.intel.com>
 <YtUV5sE8A3ayQ/Q3@google.com>
 <YtUWB1ncCr1i3V5x@google.com>
 <YtVP1ua2mS9pxK/w@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtVP1ua2mS9pxK/w@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Andy Shevchenko wrote:

> On Mon, Jul 18, 2022 at 09:12:55AM +0100, Lee Jones wrote:
> > On Mon, 18 Jul 2022, Lee Jones wrote:
> > > On Fri, 15 Jul 2022, Andy Shevchenko wrote:
> > > > On Thu, Jun 30, 2022 at 09:45:53AM +0100, Lee Jones wrote:
> 
> ...
> 
> > > > Is it okay to be applied?
> > > 
> > > Yes, I think so.
> > > 
> > > Can you collect all of the Acked-by/Tested-by tags you received
> > > and submit a [RESEND] please?  Hans' TB which should be applied to all
> > > patches springs to mind.
> > 
> > To save yourself some pain, leave off my Acks.
> 
> Actually it's less pain to leave your tags as they are now in the commit
> messages.
> 
> I will resend it soon with your tags still in.

Sure, whatever works.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
