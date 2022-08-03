Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF38A588BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiHCMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiHCMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335F1A072;
        Wed,  3 Aug 2022 05:03:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273BgHoB023513;
        Wed, 3 Aug 2022 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GnzalkEgh8cDTb75tWrLwtPfYTUvsZnCQhi2QQqTBzc=;
 b=eHB1otNZGzEIiY6kitI6Wxukbi55TjmemyWCgVhlK/XPdaHgBxSN8OyGy3bJSqbqV9Kb
 LSRWvQQSr8x9fCbhcAAUCAc3QqWhF05dBHaCih8DbcT1ZgBf/PgPYlcVGX+fHIi0z4pF
 WgjuKUYDbEhaqonggiolRp9UXwJywqYimBH2Fg/qCqTDIDI5zwEyaDnQ38UZrnVqmOcN
 54bAPb5tR7PYKQTixdjFeKyosU6a+C0USSWzQlswkachvtNTXFrc+VoUlEfcH66pouiz
 LvaHnzHLLLlLR88hyNFGOg0BOE319bE2ZKVjUcUg+ayBybSH+Y4hdKzdqPR/LQQuNvLP kw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqrcbrp1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 12:03:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 273BmEhu029360;
        Wed, 3 Aug 2022 12:01:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3hmuwhsr07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 12:01:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 273C1nRQ28508616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Aug 2022 12:01:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC62242049;
        Wed,  3 Aug 2022 12:01:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E00142042;
        Wed,  3 Aug 2022 12:01:33 +0000 (GMT)
Received: from [9.171.89.39] (unknown [9.171.89.39])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Aug 2022 12:01:33 +0000 (GMT)
Message-ID: <f2c6f744-7139-05b6-6d96-4e207dcd9c1f@linux.ibm.com>
Date:   Wed, 3 Aug 2022 14:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] random: handle archrandom in plural words
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>
References: <YtP1+MJ1tNdJA60l@zx2c4.com>
 <20220717200356.75060-1-Jason@zx2c4.com>
 <46c1a7be-080b-3315-50cc-d3c848fd99e3@linux.ibm.com>
 <YtqIbrds53EuyqPE@zx2c4.com>
From:   Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <YtqIbrds53EuyqPE@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HRjzL3yFJDN9d8vu57sKCKxbeNHkTfQy
X-Proofpoint-ORIG-GUID: HRjzL3yFJDN9d8vu57sKCKxbeNHkTfQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=635
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 22/07/2022 13:22, Jason A. Donenfeld wrote:
> On Fri, Jul 22, 2022 at 10:08:05AM +0200, Holger Dengler wrote:
>> Why not changing the API to take bytes instead of words? Sure, at the
>> moment it looks like all platforms with TRNG support are able to
>> deliver at least one word, but bytes would be more flexible. 
> 
> The idea is to strike a sweet spot between capabilities. S390x is fine
> with byte-level granularity up to arbitrary lengths, while x86 is best
> with word-level granularity of length 1. The happy intersection between
> the two is just word-level granularity of arbitrary length. Yes we
> _could_ introduce a lot of code complexity by cascading the x86 case
> down into smaller and smaller registers, ignoring the fact that it's no
> longer efficient below 32- or 64-bit registers depending on vendor. But
> then we're relying on the inliner to remove all of that extra code,
> since all callers actually only ever want 32 or 64 bytes. Why bloat for
> nothing? The beauty of this approach is that it translates very
> naturally over all the various quirks of architectures without having to
> have a lot of coupling code.

You're absolutely right. Your solution addresses all needs of current architectures. My proposal was just meant as preparation for the case, that new (smaller) architectures may come up in the future with a TRNG support, but with other granularity. But anyhow: we can handle it as soon as it happens, fine with me.


-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com
