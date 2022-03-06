Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F64CEE8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 00:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiCFXew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 18:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCFXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:34:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF8FD18;
        Sun,  6 Mar 2022 15:33:57 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 226G4dur022349;
        Sun, 6 Mar 2022 23:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fKulzWWjHvUbeYLR9eSpvMZAeO82VKShWTWsomr3sfg=;
 b=ebsXwR3b58UiZAxw8REQOMLBQqZj02pTH8M0DAPKQL225nodGQbdQMTjMIK+pR0OTx6G
 zQbx9nQNAbeEV+LYo9HxJVmQO9F8KcsOeccTljmEuSegIhP6gY/USQ1Bm1n+O7PoI84k
 XPHK9y3a7v3U7pB9enLYdhlojJ3+stW0XeVQ/g7962SfDDbDlMmVJ5PQk6ngditZyfHx
 A92wXzoA68DuCgaRGfkT2TG4WxZ7/72J3bT5J8ddBrdP5vzTI4maqko/o4llX7nL7j8L
 KSiJcC6m6ZwdLSs48ubUxb81SdupcTqBWvucGuo6hqaYa9yK2rEaKChiKdIAMke+XYue /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emsaus2kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 23:33:32 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 226NXWwS031333;
        Sun, 6 Mar 2022 23:33:32 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emsaus2k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 23:33:32 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 226NWNed015352;
        Sun, 6 Mar 2022 23:33:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3ekyg8trjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 23:33:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 226NXQHL45875516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Mar 2022 23:33:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32D5DAE051;
        Sun,  6 Mar 2022 23:33:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC116AE04D;
        Sun,  6 Mar 2022 23:33:23 +0000 (GMT)
Received: from sig-9-65-93-47.ibm.com (unknown [9.65.93.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Mar 2022 23:33:23 +0000 (GMT)
Message-ID: <4235e559d00cd90701e05befe87b06e904f008b2.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] Add CA enforcement in the machine keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, stefanb@linux.ibm.com,
        nayna@linux.ibm.com, mic@linux.microsoft.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sun, 06 Mar 2022 18:33:23 -0500
In-Reply-To: <20220301173651.3435350-1-eric.snowberg@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pM_pyezh0DokqU0Xk2f6iZDAW4RdtVqL
X-Proofpoint-ORIG-GUID: buRmEs8Kdvb52E57UDfmkaTE-dKDpi9u
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-06_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203060158
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, 2022-03-01 at 12:36 -0500, Eric Snowberg wrote:
> A key added to the IMA keyring must be signed by a key contained in either the
> built-in trusted or secondary trusted keyring. IMA also requires these keys 
> to be a CA. The only option for an end-user to add their own CA is to compile
> it into the kernel themselves or to use the insert-sys-cert.  Many end-users 
> do not want to compile their own kernels.  With the insert-sys-cert option, 
> there are missing upstream changes. 
> 
> Currently, all Machine Owner Keys (MOK) load into the machine keyring.  Add 
> a new Kconfig option to only allow CA keys into the machine keyring.  When 
> compiled with the new INTEGRITY_MACHINE_KEYRING_CA_ENFORCED Kconfig, non CA 
> keys will load into the platform keyring instead. This will allow the end-
> user to enroll their own CA key into the machine keyring for use with IMA.

In addition to only loading the MOK CA keys onto the .machine keyring,
the keyUsage should be required and limited to keyCertSign.   Certs
with keyUsage of keyCertSign should not be allowed on the IMA keyring.

thanks,

Mimi

> 
> These patches are based on Jarkko's linux-tpmdd tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 

