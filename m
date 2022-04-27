Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651251137A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359397AbiD0IcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiD0IcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:32:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D851E50;
        Wed, 27 Apr 2022 01:28:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpBjf0xHZz4xXS;
        Wed, 27 Apr 2022 18:28:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651048134;
        bh=RAXZOHFRDgEP1BvbBgYMQYJ9ZlZ566zDRR1qgQcx1Zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lBpQVFK142jpqt1vbSf08sN2zT3HN7pDXI58cDx5S7r21lDJnt9v9C8019NK0V9pk
         4PxBRu7PEbfDX/nOEoTFM2AGi6aeofBXgxenuTzdZb7bvgWtqj4iEG7l8AgcDRMiQb
         jwcILrlb3NCi8wk30P4BGZeEl/CHus99QXOZBRT9bzgWX8lBmpB/4fZAnq3sP58SJS
         5VXnIWMLiAA1EMQjZC5EJvvTKJ1CUzGhyKNZRQtBnxe20eIj5/lGi+i7WxSke4tdpg
         H67VKNQ8c0/ZSxeqxeXhhFJU9nOx4UDX26vPfcCCVR0PQzSs003/e4Eax5UVfhNF/A
         TL/mXo0IIgTJw==
Date:   Wed, 27 Apr 2022 18:28:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20220427182853.2587e788@canb.auug.org.au>
In-Reply-To: <CAL2rwxpdHGuFKCEJmOVOx-p3ri8_PLFqCDJm_5Ar6D66iQ-W9Q@mail.gmail.com>
References: <20220427133851.6ff8b0cf@canb.auug.org.au>
        <CAL2rwxpdHGuFKCEJmOVOx-p3ri8_PLFqCDJm_5Ar6D66iQ-W9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wjaYet4DyFkf4GqQdux_jgt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wjaYet4DyFkf4GqQdux_jgt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Wed, 27 Apr 2022 13:10:57 +0530 Sumit Saxena <sumit.saxena@broadcom.com>=
 wrote:
>
> Could you please try if the below patch fixes this build failure:
>=20
> From: Sumit Saxena <sumit.saxena@broadcom.com>
> Date: Wed, 27 Apr 2022 03:35:34 -0400
> Subject: [PATCH] uapi: include <linux/types.h> header in scsi_bsg_mpi3mr.h
>=20
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  include/uapi/scsi/scsi_bsg_mpi3mr.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h
> b/include/uapi/scsi/scsi_bsg_mpi3mr.h
> index 46c33efcff19..a0ddad7d84f7 100644
> --- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
> +++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
> @@ -10,6 +10,8 @@
>  #ifndef SCSI_BSG_MPI3MR_H_INCLUDED
>  #define SCSI_BSG_MPI3MR_H_INCLUDED
>=20
> +#include <linux/types.h>
> +
>  /* Definitions for BSG commands */
>  #define MPI3MR_IOCTL_VERSION                   0x06

It does not, because the uapi headers should only use the __ prefixed
versions of the kernel data types (u8 etc) and need to include
stdint.h in the not __KERNEL__ case for unint8_t etc.

So ... (this needs white space cleanups - you should probably use TAB
characters before the field names.)

diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_b=
sg_mpi3mr.h
index 6d866256f924..5167d4da478a 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -10,6 +10,11 @@
 #ifndef SCSI_BSG_MPI3MR_H_INCLUDED
 #define SCSI_BSG_MPI3MR_H_INCLUDED
=20
+#ifndef __KERNEL__
+#include <stdint.h>
+#endif
+#include <linux/types.h>
+
 /* Definitions for BSG commands */
 #define MPI3MR_IOCTL_VERSION			0x06
=20
@@ -94,12 +99,12 @@ enum command {
  */
 struct mpi3_driver_info_layout {
 	__le32             information_length;
-	u8                 driver_signature[12];
-	u8                 os_name[16];
-	u8                 os_version[12];
-	u8                 driver_name[20];
-	u8                 driver_version[32];
-	u8                 driver_release_date[20];
+	__u8                 driver_signature[12];
+	__u8                 os_name[16];
+	__u8                 os_version[12];
+	__u8                 driver_name[20];
+	__u8                 driver_version[32];
+	__u8                 driver_release_date[20];
 	__le32             driver_capabilities;
 };
=20
@@ -461,11 +466,11 @@ struct mpi3mr_bsg_packet {
=20
 struct mpi3_nvme_encapsulated_request {
 	__le16                     host_tag;
-	u8                         ioc_use_only02;
-	u8                         function;
+	__u8                         ioc_use_only02;
+	__u8                         function;
 	__le16                     ioc_use_only04;
-	u8                         ioc_use_only06;
-	u8                         msg_flags;
+	__u8                         ioc_use_only06;
+	__u8                         msg_flags;
 	__le16                     change_count;
 	__le16                     dev_handle;
 	__le16                     encapsulated_command_length;
@@ -477,11 +482,11 @@ struct mpi3_nvme_encapsulated_request {
=20
 struct mpi3_nvme_encapsulated_error_reply {
 	__le16                     host_tag;
-	u8                         ioc_use_only02;
-	u8                         function;
+	__u8                         ioc_use_only02;
+	__u8                         function;
 	__le16                     ioc_use_only04;
-	u8                         ioc_use_only06;
-	u8                         msg_flags;
+	__u8                         ioc_use_only06;
+	__u8                         msg_flags;
 	__le16                     ioc_use_only08;
 	__le16                     ioc_status;
 	__le32                     ioc_log_info;
@@ -499,20 +504,20 @@ struct mpi3_nvme_encapsulated_error_reply {
 /* MPI3: task management related definitions */
 struct mpi3_scsi_task_mgmt_request {
 	__le16                     host_tag;
-	u8                         ioc_use_only02;
-	u8                         function;
+	__u8                         ioc_use_only02;
+	__u8                         function;
 	__le16                     ioc_use_only04;
-	u8                         ioc_use_only06;
-	u8                         msg_flags;
+	__u8                         ioc_use_only06;
+	__u8                         msg_flags;
 	__le16                     change_count;
 	__le16                     dev_handle;
 	__le16                     task_host_tag;
-	u8                         task_type;
-	u8                         reserved0f;
+	__u8                         task_type;
+	__u8                         reserved0f;
 	__le16                     task_request_queue_id;
 	__le16                     reserved12;
 	__le32                     reserved14;
-	u8                         lun[8];
+	__u8                         lun[8];
 };
=20
 #define MPI3_SCSITASKMGMT_MSGFLAGS_DO_NOT_SEND_TASK_IU      (0x08)
@@ -528,11 +533,11 @@ struct mpi3_scsi_task_mgmt_request {
 #define MPI3_SCSITASKMGMT_TASKTYPE_I_T_NEXUS_RESET          (0x0b)
 struct mpi3_scsi_task_mgmt_reply {
 	__le16                     host_tag;
-	u8                         ioc_use_only02;
-	u8                         function;
+	__u8                         ioc_use_only02;
+	__u8                         function;
 	__le16                     ioc_use_only04;
-	u8                         ioc_use_only06;
-	u8                         msg_flags;
+	__u8                         ioc_use_only06;
+	__u8                         msg_flags;
 	__le16                     ioc_use_only08;
 	__le16                     ioc_status;
 	__le32                     ioc_log_info;

--=20
Cheers,
Stephen Rothwell

--Sig_/wjaYet4DyFkf4GqQdux_jgt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJo/sUACgkQAVBC80lX
0GxDSgf/YAhf8gHa8zk610soLZw8Ci0FCCLB/nVVDOK71SIDwEeyUuXenO05Jo2I
x1KkNDdFeCCLSEfsK/yBCPE0b6r8y3V1lTEpHPkj1gJbujI0HAgrNMQUVel0ZoX5
UM2NeXbdqtuD0P4aqwXQ1IaLUStu2xPnKwMaWpBXrM+0kJr/RtiIHDqLYWB3EOvB
oa5gWNZE1SzDKBPBrVD9mxFGTsPp4hrk0qYK2+cwChcuEj4FIDia4IzRxlQmwT3s
8C4oPWv4Qih87HDJ+Z12e2hg06fJN9jsyYE+OC9fAR5zGX4RsHHDnVuilXZlQu7p
GBrVplEIBGuF0AzzYKAKjv1yxY05Ag==
=NjnP
-----END PGP SIGNATURE-----

--Sig_/wjaYet4DyFkf4GqQdux_jgt--
