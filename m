Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219614D392B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiCISti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiCIStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:49:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC51A39EF;
        Wed,  9 Mar 2022 10:48:35 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229HcPMF011109;
        Wed, 9 Mar 2022 18:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ROvsIGGvRAK1ngLCXr//BxHvESKX42UqHkHp1VpPzEs=;
 b=V8eBVEVSOXpyBZ7oq/k6lE9+DV0H46qHo5twb9uvG0VbQ3InFYSYd9d3I2YKQ/8zdM7y
 xt3XyzvqHM9zGIW/CHPviBHeOyuhbL8SgrWVyMxEB21/NoVF7N1fz2HHMACfoCHA388D
 y6i/AigrOLIiiRHaBYhGTal4hxIbaAPDeGaS9V8Myh+ZySD0BW8N3AdfjbaM+XGMS07G
 5QRWtTs08IWf4mg4oUcZ7PeXvyXHCx1rqw8zeeJcijjDWV690tTyKVJ46zjyd6lvPAT7
 oXWhqfeImoyle4SW+Jio3OzpFbqNZqkCRQhbieudIOSrmGIr2i36ZdxBbzE2wlcuDF4h Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enyw9jjem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 18:43:15 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229HR6Sb011473;
        Wed, 9 Mar 2022 18:43:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enyw9jjd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 18:43:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229IY9hC030218;
        Wed, 9 Mar 2022 18:43:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnndwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 18:43:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229Ih82U30015788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 18:43:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A1011C04C;
        Wed,  9 Mar 2022 18:43:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB61011C052;
        Wed,  9 Mar 2022 18:43:06 +0000 (GMT)
Received: from sig-9-65-73-171.ibm.com (unknown [9.65.73.171])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 18:43:06 +0000 (GMT)
Message-ID: <f8390bfecbcbae7b9151e2ce65f0c8e5e4a34ce8.camel@linux.ibm.com>
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
Date:   Wed, 09 Mar 2022 13:43:06 -0500
In-Reply-To: <20220301173651.3435350-1-eric.snowberg@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DY9S9WFZUMag5c4wekPoVsmPBBCGet-M
X-Proofpoint-ORIG-GUID: vo3l3WDrmSu29pD6Wr-nZ2C8WxFmXhf9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_07,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203090101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 12:36 -0500, Eric Snowberg wrote:

I would begin by saying,

The "Enroll kernel keys thru MOK" patch set introduced a new root of
trust by defining a "machine" keyring, which is linked to the
secondary_trusted_keyring.  All Machine Owner Keys (MOK) are loaded
into the machine keyring.

Then proceed with the IMA new root of trust requirements - root CA
(self-signed CA) with keyUsage limited to keyCertSign.

> A key added to the IMA keyring must be signed by a key contained in either the

^A certificate ... must be signed

> built-in trusted or secondary trusted keyring. IMA also requires these keys 
> to be a CA. The only option for an end-user to add their own CA is to compile
> it into the kernel themselves or to use the insert-sys-cert.  Many end-users 
> do not want to compile their own kernels.  With the insert-sys-cert option, 
> there are missing upstream changes. 
> 
> Currently, all Machine Owner Keys (MOK) load into the machine keyring.

Moved to the beginning.


> Add

^Define
>  
> a new Kconfig option to only allow CA keys into the machine keyring.  When 

Add the other criteria here as well.

> compiled with the new INTEGRITY_MACHINE_KEYRING_CA_ENFORCED Kconfig, non CA 
> keys will load into the platform keyring instead. This will allow the end-
> user to enroll their own CA key into the machine keyring for use with IMA.
> 
> These patches are based on Jarkko's linux-tpmdd tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

thanks,

Mimi

