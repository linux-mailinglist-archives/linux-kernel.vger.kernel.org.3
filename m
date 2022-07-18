Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F1578AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiGRTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiGRTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:33:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0C313A5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:33:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so14060560wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xwOi0/YqmOj47DIS9XkftfFeH7Ad13wjAtHDSHbI450=;
        b=dGi9GSHC3uV2Tx+fDM28pxHAquxspdxN8voOAbb77fxkDwlidDStGMPx0u1hlsg0Tc
         C+P8FNd53X+vyHsguz+nyUbW18/k6VGIdk3iNfN0FatsqpowDxnL+j1fGlibN7HP08pb
         Nq4E1Pj9i3facXWRddVbV48qTk05INDrTnH9CWqUSzq+6gHvmerw3cDnOOHP8ZBySB+r
         zyhEwqp0FIs2SMZ3sXpeJTXM8pDsZcIngeJ3uyb4XETFL7749EocVjR8JdjrTSJgMpPe
         44SljfFn1L5ZFAfGPtSzw9MwV1EmBIa1U55qsvFPvibrwdS2u4b1cfgV6l307WeN0gd8
         Ckzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xwOi0/YqmOj47DIS9XkftfFeH7Ad13wjAtHDSHbI450=;
        b=RGnsJcfhv0VfCFq7mkDnToylCg8Ygbb1LmlrskPsmki657Eg7UNu0HOSZwmpmKvYRi
         UtjKE3XcOn/tUB/P/XeJc6j7P5H7rEC6YAmSYHJeN7SryS21TPjY0jPMAyOmPntA0SLc
         taut2ZjCgKJBzafuxKYMRH0K+q/JCv3tnpRgcEQ7E/KzkGu/N2S6KZLjZMoJr4GqMiBK
         wr20sLShx9y/cjC2Slff1e6ksa86A5KqHB0k/t5bgfYY6i1f2KKq9fat1pI7PDZKnuz/
         1BOcQah++Hima/Di3rCSqFecPN0qBpkk0Hpwj4u8u9ZkjW1shCSoWxReqyjrj60D4F36
         IZKQ==
X-Gm-Message-State: AJIora/R268xh+JTMqCkxJh3gITVukR6Oevz/F8Z2/9Ij3l0CZEVhsoe
        KOiBaTV/Be8dHYWIoJMTVZU=
X-Google-Smtp-Source: AGRyM1tZcdrTnOWuKMDCpj3dhGwlJ+rKD67mfQ2bDQGJl9jWR4hOcIzV8+LPffjMUcNiEGlPaGCjaQ==
X-Received: by 2002:a05:6000:1ac8:b0:21d:b7d9:3c03 with SMTP id i8-20020a0560001ac800b0021db7d93c03mr23155250wry.149.1658172790485;
        Mon, 18 Jul 2022 12:33:10 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6999:b072:faf1:1e0f:8765? (p200300c78f2e6999b072faf11e0f8765.dip0.t-ipconnect.de. [2003:c7:8f2e:6999:b072:faf1:1e0f:8765])
        by smtp.gmail.com with ESMTPSA id m185-20020a1c26c2000000b003a302fb9df7sm16061235wmm.21.2022.07.18.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:33:10 -0700 (PDT)
Message-ID: <adbd6481-4ea0-0e9b-5249-9ab2b843a450@gmail.com>
Date:   Mon, 18 Jul 2022 21:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] staging: vt6655: Rename dwData to reg_value in four
 macros
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
 <b54577316eebdbb54e478fc51473eeba9d7eacae.1658094708.git.philipp.g.hortmann@gmail.com>
 <c040cd03d04fb861b85b4f56cd04b473bb778ebd.camel@perches.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <c040cd03d04fb861b85b4f56cd04b473bb778ebd.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 08:07, Joe Perches wrote:
> Please remember that checkpatch is a stupid little scripted tool
> and the actual goal is to have readable code.
Understood.
> 
> Look a bit beyond the code and see if and how you could make the
> code better.
> 
> All of these macros have the same form and logic.
> 
That is the reason why I put them all together in one static function:
static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
{
	unsigned long reg_value;

	reg_value = ioread32(iobase + reg_index);
	if (reg_value & DMACTL_RUN)
		iowrite32(DMACTL_WAKE, iobase + reg_index);
	else
		iowrite32(DMACTL_RUN, iobase + reg_index);
}

> Perhaps it'd be better to use another indirect macro and define
> all of these with that new macro.
> 
> Something like:
> 
> #define mac_v(iobase, reg)						\
> do {									\
> 	void __iomem *addr = (iobase) + (reg);				\
> 	iowrite32(ioread32(addr) & DMACTL_RUN ? DMACTL_WAKE : DMACTL_RUN,\
> 		  addr);						\
> } while (0)
> 
> #define MACvReceive0(iobase)	mac_v(iobase, MAC_REG_RXDMACTL0)
> #define MACvReceive1(iobase)	mac_v(iobase, MAC_REG_RXDMACTL1)
> #define MACvTransmit0(iobase)	mac_v(iobase, MAC_REG_TXDMACTL0)
> #define MACvTransmitAC0(iobase)	mac_v(iobase, MAC_REG_AC0DMACTL)

That is an interesting solution. But for me this code is not as good 
readable as my proposal. Reason is that I struggle with the function in 
function with condition broken into two lines.
