Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC35A7423
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiHaCwk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 22:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiHaCwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:52:39 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF421B517B;
        Tue, 30 Aug 2022 19:52:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNoxS42_1661914354;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VNoxS42_1661914354)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 10:52:35 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v1 5/9] crypto/ycc: Add skcipher algorithm support
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <MW5PR84MB1842B41754897B029B6949E5AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Wed, 31 Aug 2022 10:52:34 +0800
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        "xuchun.shang@linux.alibaba.com" <xuchun.shang@linux.alibaba.com>,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <037A82F1-7C15-44E2-96B9-57CFEC936D38@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
 <1661334621-44413-6-git-send-email-guanjun@linux.alibaba.com>
 <MW5PR84MB1842B41754897B029B6949E5AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliott,

> 2022年8月25日 上午12:24，Elliott, Robert (Servers) <elliott@hpe.com> 写道：
> 
> 
> 
>> -----Original Message-----
>> From: 'Guanjun' <guanjun@linux.alibaba.com>
>> Sent: Wednesday, August 24, 2022 4:50 AM
>> Subject: [PATCH v1 5/9] crypto/ycc: Add skcipher algorithm support
>> 
> ...
> 
>> +static struct skcipher_alg ycc_skciphers[] = {
>> +	{
>> +		.base = {
>> +			.cra_name = "cbc(aes)",
>> +			.cra_driver_name = "ycc_cbc(aes)",
> 
> In comparison, the aead driver puts the hardware driver name as a suffix,
> not a prefix, and uses dashes rather than underscores and parenthesis:
>> +			.cra_name = "gcm(aes)",
>> +			.cra_driver_name = "gcm-aes-ycc",
> 
> and the pk driver uses a prefix with a dash:
>> +		.cra_name = "rsa",
>> +		.cra_driver_name = "ycc-rsa",
> 
> Although the existing drivers are wildly inconsistent, it would be nice
> if this driver was at least consistent with itself. Suffixes with dashes
> seem to be the most popular, so consider these formats:
>  cbc-aes-ycc
>  gcm-aes-ycc
>  rsa-ycc
> 


Thanks for your comments. I will change these names as your suggestion in next version.

Best regards,
Guanjun

