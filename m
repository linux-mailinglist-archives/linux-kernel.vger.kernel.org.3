Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341E24E3D04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiCVKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiCVKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:55:48 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0E12776
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:54:20 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KN7f33TrrzMprjy;
        Tue, 22 Mar 2022 11:54:19 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KN7f26RddzljsTT;
        Tue, 22 Mar 2022 11:54:18 +0100 (CET)
Message-ID: <d1a23bfa-9160-7270-2180-d9720c12a5cc@digikod.net>
Date:   Tue, 22 Mar 2022 11:55:25 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321174548.510516-1-mic@digikod.net>
 <f595c9c2da606b799f3a8ded9807cb6d892156c5.camel@infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 0/1] Explain panic() calls for keyring initialization
In-Reply-To: <f595c9c2da606b799f3a8ded9807cb6d892156c5.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/03/2022 19:29, David Woodhouse wrote:
> On Mon, 2022-03-21 at 18:45 +0100, Mickaël Salaün wrote:
>>
>> Mickaël Salaün (1):
>>    certs: Explain the rational to call panic()
> 
> Nit: "rationale". Even in Simplified English, I believe "rational" is a
> completely different word.

Right, "rational" is an adjective.


> 
>>   certs/blacklist.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> Also, isn't it about time we changed this to call it a denylist?
> 

It is important to note that this word is part of the kernel ABI because 
of the keyring name.
