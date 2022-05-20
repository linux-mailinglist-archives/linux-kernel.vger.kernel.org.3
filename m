Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59852EA89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbiETLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348407AbiETLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:11:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932093EF22;
        Fri, 20 May 2022 04:11:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KAhckt022523;
        Fri, 20 May 2022 11:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kJVoVYK/ONGaiB5tlKh4bH8Chhvp/q4lg9PLkDF6dWw=;
 b=S+xYyxqBN8J8IaiZBXMfyHn5FHGyghBwCvz1hH93ggDefOOrOpnVBRP2of/bBZ8TL787
 y7wfQZHCM/yD6kzjhLTbn90tU/Ji7zVmoWsjO2vWWUz6543sPwfG1oXtax8GIe5sLUhE
 SugYV/x0Cjj+dcA9WQJiUuCaeN9YHkK9emVhNE3KffueLTx6UMm7nGkehtrgY8VBU7uE
 b2cM1/VEBuIy8q3oALEp4SPqY4HoirFUpJ5MeZetm1eJHeY9xz2g0g+yovk4A1tmXoSP
 FGjecKUt6Uif/BiQiRG7EJNotBDC3ramwfW+ZawKSfbhoC9HPtDMqPpjFuAIsoyBJ5DC GA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g62qng659-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 11:11:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KB72XM027654;
        Fri, 20 May 2022 11:11:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjgpxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 11:11:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KBAajl32375278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 11:10:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66FF8A404D;
        Fri, 20 May 2022 11:11:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 167E5A4040;
        Fri, 20 May 2022 11:11:16 +0000 (GMT)
Received: from osiris (unknown [9.145.81.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 20 May 2022 11:11:16 +0000 (GMT)
Date:   Fri, 20 May 2022 13:11:14 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] s390: Add attestation query information
Message-ID: <Yod3Uiu2hRc9vas7@osiris>
References: <20220518135908.1110319-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518135908.1110319-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nGudQSKKXq0IiARFzdpVgNJN6rLdNBE9
X-Proofpoint-GUID: nGudQSKKXq0IiARFzdpVgNJN6rLdNBE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=737 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205200082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:59:07PM +0000, Steffen Eiden wrote:
> By design the uv-device does not check whether an incoming attestation
> measurement request only specifies valid plaintext flags or has the
> right request version, as these values are verified by the Ultravisor
> anyway. However, the userspace program that generates these requests
> might want to know which flags/versions are supported in order to
> create requests without trial and error. Therefore, we must expose the
> supported plaintext flags and versions to userspace.
> 
> since v1:
> 	* rebased on Janosch's "kvm: s390: Add PV dump support" series
> 	* added rationale as this cover letter

Thanks for adding the cover letter! However what I really meant (and
failed to write) is that the rationale should be part of the patch
description. Anyway; whoever picks this patch will hopefully integrate
your cover letter description into the commit.
