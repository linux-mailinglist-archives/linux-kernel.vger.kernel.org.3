Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A94F16CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbiDDONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377180AbiDDOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:13:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCE13D77
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:11:06 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DaWjh024879;
        Mon, 4 Apr 2022 14:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PyNS/bPsOVI22ihG5fBt4CtDfj3ZRwSVjnEbFideBoQ=;
 b=l+uuBYk3vpXHsZhjEJMzf5hqajHhYX0Sm3WzxySGkdiRGZ+v1sMTBq2K7dMm8Hmoor4z
 WCzlDxV3B3i6BW9ip3sYF+WThjvYvgHBifhsNUNr+Nw4O7qN1J+sLoTAbzWSmWlQocza
 ds/58VBd5r84mlxAuUOjh9iK4Qr+5qlpWBHfm28pL8Q/B/xoi5EVsgRoEqQsnuQYEaGi
 OII9vqNSSL+SNddPko2RJijPFOXGitRZ5lEdF2wLvFDELhDM2aTp0Bd0WHnJxdr+MXjx
 0cjTSI/1jckOSmdQ676lE6ilSAVdM0KJaLr4AhhHDQnDSyABILgThZnWapcQ31j8bCoF Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f705gwfg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 14:10:35 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 234Dbfd5031762;
        Mon, 4 Apr 2022 14:10:35 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f705gwffb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 14:10:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234Dx2TZ001915;
        Mon, 4 Apr 2022 14:10:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3f6e48u55h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 14:10:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 234EAUpK24903980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 14:10:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 972D35204E;
        Mon,  4 Apr 2022 14:10:30 +0000 (GMT)
Received: from [9.43.18.41] (unknown [9.43.18.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7443752050;
        Mon,  4 Apr 2022 14:10:26 +0000 (GMT)
Message-ID: <de6529b0-9360-cf4a-4233-ee1498b44176@linux.ibm.com>
Date:   Mon, 4 Apr 2022 19:40:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: mm: fix pmd_leaf()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        steven.price@arm.com, lengxujun2007@126.com,
        Arnd Bergmann <arnd@arndb.de>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <20220403024928.4125-1-songmuchun@bytedance.com>
 <20220404091957.GA22790@willie-the-truck>
 <CAMZfGtU=4aFmbwyyh+5=M3iaqox7X7yaoPP+r=WJO9dReaNb-g@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAMZfGtU=4aFmbwyyh+5=M3iaqox7X7yaoPP+r=WJO9dReaNb-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f95HA5y8MY6PG0YKkvESVVe_OJU5fK-p
X-Proofpoint-ORIG-GUID: QEYCWY9O8XvzNMN89T7wa9FKUMBbm0mu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040081
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 5:10 PM, Muchun Song wrote:
> On Mon, Apr 4, 2022 at 5:20 PM Will Deacon <will@kernel.org> wrote:
>>
>> On Sun, Apr 03, 2022 at 10:49:28AM +0800, Muchun Song wrote:
>>> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
>>> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
>>> caused by this was reported by Qian Cai.
>>>
>>> Link: https://patchwork.kernel.org/comment/24798260/ [1]
>>> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
>>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>   arch/arm64/include/asm/pgtable.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 94e147e5456c..09eaae46a19b 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>>                                 PMD_TYPE_TABLE)
>>>   #define pmd_sect(pmd)                ((pmd_val(pmd) & PMD_TYPE_MASK) == \
>>>                                 PMD_TYPE_SECT)
>>> -#define pmd_leaf(pmd)                pmd_sect(pmd)
>>> +#define pmd_leaf(pmd)                (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>>>   #define pmd_bad(pmd)         (!pmd_table(pmd))
>>>
>>>   #define pmd_leaf_size(pmd)   (pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
>>
>> A bunch of the users of pmd_leaf() already check pmd_present() -- is it
>> documented that we need to handle this check inside the macro? afaict x86
>> doesn't do this either.


ppc64 also doesn't do a pmd_present check.

>>
> 
> arm64 is different from x86 here. pmd_leaf() could return true for
> the none pmd without pmd_present() check, the check of
> pmd_present() aims to exclude the pmd_none() case.  However,
> it could work properly on x86 without pmd_present() or pmd_none().
> So we don't see pmd_present() or pmd_none() check in pmd_leaf().
> For this reason, I think this check is necessary.
> 
> BTW, there are some users of pmd_leaf() (e.g. apply_to_pmd_range,
> walk_pmd_range, ptdump_pmd_entry) which do not check pmd_present()
> or pmd_none() before the call of pmd_leaf().  So it is also necessary
> to add the check.
> 


I would expect pmd_leaf check to return true, if the said pmd page table 
entry can point to a leaf page table entry which can also be a not 
present page table entry?

-aneesh
