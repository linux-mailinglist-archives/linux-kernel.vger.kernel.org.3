Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6524D06AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiCGSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiCGSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:38:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8965B89300;
        Mon,  7 Mar 2022 10:37:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227HdPbZ018892;
        Mon, 7 Mar 2022 18:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eUNW/6skSv3OxYGVZrUDJ328Q8X50piMjlXINaMMmCU=;
 b=ZugJ44GXvgXzxKGpFGf7H6Hh4DBrkykqfNezS3ijXgC7wxlHIB1BajiVsFreO7pjqQs1
 DJOWitmylKBXyvQ4Er33Ac/uhO8zgo73yEthF6nlwcW9Yh5e42GjUdPzXQELPCtZCD96
 GwdpGRHdUthWUW3ufWugQen+FE+ZBxPfAL4kDBjy9e3StIWxh+SeEx5vfGAF19vYZaBj
 VrLrbYwsVRBWW0huc6OYDuFKoIhVKBXxfM5N+t5VyjiuBwEh/aGQZ5z+JopOYVhj9WOu
 qBl5L1ngZFeekM54upnXIA2fAlY6wrKvR6ANVSfwAuHIJlD88WuZi+2cx6Oy6jzMlqBW Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3enmg1cbrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 18:36:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 227IKkIK018370;
        Mon, 7 Mar 2022 18:36:50 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3enmg1cbrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 18:36:50 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 227IYtSr027270;
        Mon, 7 Mar 2022 18:36:49 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3ekyg9ujjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 18:36:49 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 227Ialdf13763150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 18:36:47 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D01D6E053;
        Mon,  7 Mar 2022 18:36:47 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B89F6E050;
        Mon,  7 Mar 2022 18:36:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 18:36:45 +0000 (GMT)
Message-ID: <571dbcce-e97f-fe4b-fdff-34f84a43e1a8@linux.ibm.com>
Date:   Mon, 7 Mar 2022 13:36:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] integrity: CA enforcement in machine keyring
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-5-eric.snowberg@oracle.com>
 <59f08890-f3f9-43fe-e1cc-6648071e33e0@linux.ibm.com>
 <64A87331-C97E-4565-B222-9BF7208E5010@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <64A87331-C97E-4565-B222-9BF7208E5010@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xoLFr6et3NzFtnQgYv1Dpj7DLd6efZNy
X-Proofpoint-ORIG-GUID: QA-Hqn0hU2juqdmZSkaL0fKgxuef-RCO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_10,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203070104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 13:13, Eric Snowberg wrote:
> 
> 
>> On Mar 4, 2022, at 4:19 PM, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>> On 3/1/22 12:36, Eric Snowberg wrote:
>>> When INTEGRITY_MACHINE_KEYRING is set, all Machine Owner Keys (MOK)
>>> are loaded into the machine keyring.  Add a new
>>> INTEGRITY_MACHINE_KEYRING_CA_ENFORCED option where only MOK CA keys are
>>> added.
>>>
>>> Set the restriction check to restrict_link_by_ca.  This will only allow
>>> CA keys into the machine keyring. Unlike when INTEGRITY_MACHINE_KEYRING
>>> is enabled, IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY may
>>> also be enabled, allowing IMA to use keys in the machine keyring as
>>> another trust anchor.
>>
>> I tried to test this but could only do it by disabling the MokListTrustedRT variable check and then also the check for secure boot. It did load the expected keys onto the .machine keyring, enforcing the x509 indicating a self-signed CA if the compile time option CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED=y was set, loading all keys in the case of CONFIG_INTEGRITY_MACHINE_KEYRING=y.
>>
>> I tried with this branch here from mokutils https://github.com/esnowberg/mokutil/tree/trust-mok but this seems to create an EFI variable with a different name. I guess this is the wrong branch?
> 
> Thanks for testing.  During the shim review, Peter requested an EFI variable name
> change. This did not impact anything in the kernel.  However it did impact mokutil.
> The necessary mokutil changes are available in this pull request:
> 
> https://github.com/lcp/mokutil/pull/49
> 

The following is in Jarkko's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=4d83e5144e224b90f6589d11b5fecde33c0dd211


+
+/*
+ * Try to load the MokListTrustedRT MOK variable to see if we should trust
+ * the MOK keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, MOK keys should not be trusted
+ * within the machine keyring.
+ */
+static __init bool uefi_check_trust_mok_keys(void)
+{
+	struct efi_mokvar_table_entry *mokvar_entry;
+
+	mokvar_entry = efi_mokvar_entry_find("MokListTrustedRT");
+
+	if (mokvar_entry)
+		return true;
+
+	return false;
+}

I don't think this works  with your mokutil PR:

static int
trust_mok_keys()
{
	return set_toggle("MokListTrustedNew", 0);
}

 From what I saw, MokListTrustedRT searches for a mok-variable entry in 
the MOK-specific directory in sysfs while MokListTrustedNew creates one 
in the EFI dir...

     Stefan
