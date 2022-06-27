Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A51955B592
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiF0DTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiF0DT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:19:28 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D02E64;
        Sun, 26 Jun 2022 20:19:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VHRTHrs_1656299959;
Received: from 30.240.101.24(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VHRTHrs_1656299959)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 11:19:21 +0800
Message-ID: <58792bb9-c25c-d457-a57c-b82a4d42533f@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 11:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/2] pkcs7: support SM2/SM3 and EC-RDSA/streebog
 algorithms
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Elvira Khabirova <e.khabirova@omp.ru>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210918080737.17252-1-tianjia.zhang@linux.alibaba.com>
 <ea7d5934-01f4-bd2e-09d5-0916eb72e8d8@linux.alibaba.com>
 <Yrf5QWnKL2ocoEq6@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Yrf5QWnKL2ocoEq6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 6/26/22 2:14 PM, Jarkko Sakkinen wrote:
> On Fri, Jun 17, 2022 at 05:19:03PM +0800, Tianjia Zhang wrote:
>> Hi Jarkko,
>>
>> On 9/18/21 4:07 PM, Tianjia Zhang wrote:
>>> This series of patches integrates the two patches sended separately,
>>> resolves the conflict, and rebases on the latest code.
>>>
>>> The two patches respectively support the SM2/SM3 and EC-RDSA/streebog
>>> algorithm combinations for the pkcs7 parser.
>>>
>>> Elvira Khabirova (1):
>>>     pkcs7: support EC-RDSA/streebog in SignerInfo
>>>
>>> Tianjia Zhang (1):
>>>     pkcs7: parser support SM2 and SM3 algorithms combination
>>>
>>>    crypto/asymmetric_keys/pkcs7_parser.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>
>> No response from David, can you pick this?
>>
>> Best regards,
>> Tianjia
> 
> You should CC me the series then.
> 
> BR, Jarkko

Thanks, I will resend these series.

Best regards,
Tianjia
