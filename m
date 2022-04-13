Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DC4FFB44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiDMQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiDMQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:29:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B821729C88
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:27:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l7so5078012ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=dHSB2OunSV8N2CP9NqgGCpEjqZt2Tp1gm+JIRx281WY=;
        b=kVzls8+Jm+5l8AlSNCM9fh+KtEc68H/XiJChaqcD36C7J0LzgT7YgfLZrpmzHeCwti
         uGRwzF0joozPRAuIdSVCmgR8qkSaILYa+q4Nq6jNQyH6rc8sXi5KPZa02v6rtFHB3FnS
         zJYEcGjvhNHxgpERIgk62ePTbzGBLQHTsXl2viYHMBP93FfcRlP3hRX7uf2E+l7mEw12
         l7Tq1pHOnzeKiY8fgHEa10FuPwa8ugh1WfD2qs3eKOcB9qtUO39BdBXaafVSB6YKEuFG
         tRwjI8Z6Mnli8HWadcCsaHSpZ6i/tMsS6ijfKVrw94tz7keMLHByw0MGjVgYI0NVO3KR
         /+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=dHSB2OunSV8N2CP9NqgGCpEjqZt2Tp1gm+JIRx281WY=;
        b=vMIcEUDdutNxDUK79JFnXuJgcHMjr1OcC8ZDPauDQjFzcTEzmENaqxLwjr6uWF4pE7
         bIlD8OGSpFE3ehCwGFXhD7sv2kfcEwFMKel5kbj4lVpoOaJSzoQ0UW1oZXpq1eM2xjOJ
         lKNqF2TUIIalhvxMLzqZykW6VM+JK3+Tp55MmTS+i1hbZkO3H1AiRaBPeKV8/boGDLxn
         vjs+ETAlQ748MplLsyf5nvVR4Xg08gifAHAlRO8DL8phW7haTlClM5yLwpdK3CPSe/aJ
         lsf132C+zkd0gHQ4KxFWi+95DRWW8p169wP3Ea4wVmF9c/34xnXFoZiXSIaD1rhrhUO5
         B5Eg==
X-Gm-Message-State: AOAM531ph4/bFxHC01q4h36/2wzS4DnW/zJqI3Eh768biyT0sXk4Qz64
        QmgnXb9JMiu0Zj4H/oYzWP0=
X-Google-Smtp-Source: ABdhPJwugGCsX7h22o//7EA8siY4JDgQuOv/CXKsTbwyvqiHxO+ueNSthSfqC4XlZzhblOSnMAfArA==
X-Received: by 2002:a17:907:8a0e:b0:6e8:c5df:d9e with SMTP id sc14-20020a1709078a0e00b006e8c5df0d9emr4124725ejc.142.1649867250201;
        Wed, 13 Apr 2022 09:27:30 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b00420119333c1sm449703edj.62.2022.04.13.09.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:27:29 -0700 (PDT)
Message-ID: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
Date:   Wed, 13 Apr 2022 18:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        straube.linux@gmail.com
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: r8188eu: struct rt_firmware_header issues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think the rt_firmware_hdr structure in rtw_fw.c has some issues.


struct rt_firmware_hdr {
	/*  8-byte alinment required */
	/*  LONG WORD 0 ---- */
	__le16		Signature;	/* 92C0: test chip; 92C,
					 * 88C0: test chip; 88C1: MP A-cut;
					 * 92C1: MP A-cut */
	u8		Category;	/*  AP/NIC and USB/PCI */
	u8		Function;	/*  Reserved for different FW function
					 *  indcation, for further use when
					 *  driver needs to download different
					 *  FW for different conditions */
	__le16		Version;	/*  FW Version */
	u8		Subversion;	/*  FW Subversion, default 0x00 */
	u16		Rsvd1;

	/*  LONG WORD 1 ---- */
	u8		Month;	/*  Release time Month field */
	u8		Date;	/*  Release time Date field */
	u8		Hour;	/*  Release time Hour field */
	u8		Minute;	/*  Release time Minute field */
	__le16		RamCodeSize;	/*  The size of RAM code */
	u8		Foundry;
	u8		Rsvd2;

	/*  LONG WORD 2 ---- */
	__le32		SvnIdx;	/*  The SVN entry index */
	u32		Rsvd3;

	/*  LONG WORD 3 ---- */
	u32		Rsvd4;
	u32		Rsvd5;
};


Then we have in rtl8188e_firmware_download():


	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;

	<snip>

	if (IS_FW_HEADER_EXIST(fwhdr)) {
		/*  Shift 32 bytes for FW header */
		fw_data = fw_data + 32;
		fw_size = fw_size - 32;
	}

We add/sub 32 bytes but the size of struct rt_firmware_hdr is actually
33 bytes. I noticed this when I wanted to replace:

		fw_data = fw_data + 32;
		fw_size = fw_size - 32;

with:
		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
		fw_size = fw_size - sizeof(struct rt_firmware_hdr);;

To me it looks add/sub 32 is correct here but the struct is
wrong. I don't know if the firmware for this driver is so much different
from firmware for the drivers in drivers/net/wireless/realtek/rtlwifi.
They use a struct of size 32.

Also, souldn't the u16 and u32 variables in the struct be __le16 and
__le32 ?

I wonder if we can just use the rtlwifi_firmware_header structure from
drivers/net/wireless/realtek/rtlwifi/wifi.h ?

Comments from people with better knowledge appreciated. :)

regards,
Michael


