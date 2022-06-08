Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F6543CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiFHTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiFHTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:33:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68C451E73FA;
        Wed,  8 Jun 2022 12:33:42 -0700 (PDT)
Received: from [10.16.8.184] (unknown [131.107.147.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id A896E20BE665;
        Wed,  8 Jun 2022 12:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A896E20BE665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654716821;
        bh=9VPqD11Y0U15W613gU8t13a2O2PKBaCp3UdzdYQ4GpQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=WhxkAlfE/Arw1RbLOc7GEnlQmI2Ol2oj9XSLISpdfl1thZVJCkxMpYubDUAIfp6gg
         qzT1HybGTMPU538EVfXltAv3LCVgFXVxdeKXiiAmKKD3USU/q0s8/vVNvxd6sOBC9s
         6eAoj0OttVQQb2g3fgR8EyvCwRtYvdmQyszSk3gk=
Message-ID: <6f9e1481-db9c-cd5f-c38d-bdcd3040315f@linux.microsoft.com>
Date:   Wed, 8 Jun 2022 12:33:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: Re: [PATCH 5/5] crypto: aspeed: add HACE crypto driver
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-6-neal_liu@aspeedtech.com>
Content-Language: en-US
In-Reply-To: <20220601054204.1522976-6-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2022 8:43 PM, Neal Liu wrote:
>>> +struct aspeed_hace_alg {
>>> +	struct aspeed_hace_dev		*hace_dev;
>>> +	union {
>>> +		struct skcipher_alg	skcipher;
>>> +		struct aead_alg		aead;
>>> +		struct ahash_alg	ahash;
>>> +		struct kpp_alg		kpp;
>>> +		struct akcipher_alg	akcipher;
>>
>> Your patch dont do any kpp or akcipher (and aead/skcipher also).
>> Please drop this.
>
> I miss this part, I'll revise it in next patch, thanks.

Hi Neal,

Are you planning to submit aead separately? HW programming interface
for aes-gcm is almost same as other aes modes except extra regs/fields 
for tag etc.


Thanks,
Dhananjay


