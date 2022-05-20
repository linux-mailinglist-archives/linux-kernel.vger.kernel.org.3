Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A552152F220
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbiETSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbiETSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:11:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCE5D653;
        Fri, 20 May 2022 11:11:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFVNQx016707;
        Fri, 20 May 2022 18:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=24Dvykp2KUkjJ6d/E8Qq50Ojk1N4J0gGWIZsa/gjTL0=;
 b=VMngJluL69wMtwtlGk9gS7JO/bSTSL9qWSn8K8qjSPLan8xC0Sm9QoNmBRlFgyD3w6L2
 n32qZYGGav2KQZ1SvCv8ERgAKljGXVv361JlkqdbXUf0xUCQaFS4Ko57NPKEHGOXlA12
 nWohyJRw+vicYNDs/HVwf1iS3TGqlBEkCKOU2EUeEq0WIAwIWpi4wSIDIa+yq+THIIfs
 P43LWjq42vYi1JDxyCK626BMPYfWFV3G+ouWb8K1OAHk5MlJkVJgGdRpbfMH8RXImDnI
 4zeF0pPf0CRCFrx9D7/NXWWnhIQV92JUoPrSBIsEurSVbJkJbuvHVEV2h7WtFIax1jOR vA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6b7eenye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 18:11:20 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KHv39v001053;
        Fri, 20 May 2022 18:11:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3g242902yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 18:11:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KIBG5p43647418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 18:11:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EF7A42041;
        Fri, 20 May 2022 18:11:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 990E84203F;
        Fri, 20 May 2022 18:11:15 +0000 (GMT)
Received: from localhost (unknown [9.43.91.35])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 18:11:15 +0000 (GMT)
Date:   Fri, 20 May 2022 23:41:13 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: changed messages in qemu boot
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20220520233602.2738d87c@canb.auug.org.au>
In-Reply-To: <20220520233602.2738d87c@canb.auug.org.au>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1653069342.3xtfot6wli.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wi4CIOHTYoPB9DtNtrBg2pnd-QI3Mc4e
X-Proofpoint-ORIG-GUID: Wi4CIOHTYoPB9DtNtrBg2pnd-QI3Mc4e
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_05,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next bboot of the powerpc pseries_le_defconfig build
> produced these different kernel messages (diff from yesterday's tree):
>=20
> - ftrace: allocating 33658 entries in 13 pages
> - ftrace: allocated 13 pages with 3 groups
> + ftrace-powerpc: Address of ftrace_regs_caller out of range of kernel_to=
c.

Thanks for the report. I think that is due to:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/bb6626e884acffe87b5=
8736291df57db3deaa9b9.1652074503.git.christophe.leroy@csgroup.eu/

The below diff fixes it for me:

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace=
/ftrace.c
index 46c002a8388804..7418da705d43ac 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -746,7 +746,7 @@ int __init ftrace_dyn_arch_init(void)
=20
        reladdr =3D addr - kernel_toc_addr();
=20
-       if (reladdr >=3D SZ_2G || reladdr < -SZ_2G) {
+       if (reladdr >=3D SZ_2G || reladdr < -_UL(SZ_2G)) {
                pr_err("Address of %ps out of range of kernel_toc.\n",
                                (void *)addr);
                return -1;


- Naveen

