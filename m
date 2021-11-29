Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B34612DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353822AbhK2Kvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:51:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1224 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353881AbhK2Ktq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638182787; x=1669718787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFnO0oI+/n0wgS4lLFYJQKjEz0bjuPW36HxP2ApdusQ=;
  b=i8DJEW84HsFpqADMKCYY1XuPy47KhKoNCjCkkUu4RdCD4x4+KTbgNxHK
   WvN7fWMKB9EL/62KBvk4bAiHgyamp4lWf8nvYVtTJvnVjeVKTL9ws1rht
   YUgmYP5BBpfxOg6E0f6Bo8335Mo19FayXhPC0W1FqpW5Z9vIf2AvhxNm7
   wMgSwRqgF8gahX/ll/BXuIismnAWR38XirNmr5Qriet9G/q6YaL9r3ou5
   +SQDg3O/qvK8IqjTKLyciKEfG+JRQqvv7I8TYLDpsNKKo9YesuE4H3G8K
   bEVc9L6rxuxxJiXtlWgwBtPKF6+EbrBVYXjd3p/6KfUfENw0CZrrw+gYO
   A==;
IronPort-SDR: 69dbcLyfbqByOj62Vq93FrN7XqiKew0qnRfzldGX3TmLVwpYW15aUbkOIfDSlM0Ed1umh+q3NR
 ZEm4Uwz/S76D78lLTnOXkTEj4Ekojax4mZixf9rVk+8Lwg7t8XKKiTqjey5CI8QuTWQrJIrkP0
 ZiCJVVUidSOLaCe4hDIJ7zUyeXAKkWIjtGh7L2PVlaxj0WfJ0bmJXtp1Gnmd/N72d/PR78qVjj
 mDPDiPT1V3CGLuh59I5ydscZceorqHALQnLCXOrsV2FyT4C3BsjTBPWA/LC6xQNZsKAC5FZHn6
 fpX7r5ZJr2GqFrn4QOC3mxdc
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="153518223"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2021 03:46:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 29 Nov 2021 03:46:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 29 Nov 2021 03:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJd3Svrr+RWEcbNqYzaVryLfmNi5V5O7PSMR3E8B/4P3+EHLBy0fzkVz2GEMEZbK92wFpYjUZeLD9V9VzpVmR4gKxUDu9hgcrjp8xkGSW7q4UB4Z/mpblszoRhd0BVcVbHttRVB+Bycu8joRDaRm4Fl1GUvPZVLPBzB8DAm4JBIbfbXZRrSCx1GQOAFZ/NCANu6oRSqv6L93t1+qz70gUtIs3vx2OS5UYT49oGSixzFI1BKoYlQvvUqR/9cVcgHIUYw73b6+K55gVFEA1RiaYPGsoK8Kihh3PQubj8wnxHdNxfVwXK5OS1/kj0CAgxuU0s7K5DXO5k3nwaxV+hM8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1NrmwYvUFSaPeMtRStRIcPn31hNUz/oUr0foacRZVQ=;
 b=boDQLSzG+p1YIKvJw/8bqCfUJ8tcOuWvTlpb1YT3NFFpqZZUyofxVpBeciKnbM0Q7lmGQPMKmc9vNt/t1PjHzUwhN0j/euIY03NOfui8DbxrmROqq5QsCvbU7IEXLztEbR1Q5xXQtKp51Y3oKGE9xMXLzFGtfoIiQogKOE29SnbVWk5Sikb/ISYIp1b7953MWH0E+VEXqnxW9d6jnlKVMzTRO/GC6j46QmWcNZ/K6atcNbdNfTF27IsMJvujmraPHHTrF9ug8wuGgW/+KA6LT2ipS3528n4VzwU5Su8WmDog6Sl2NNcTsELVBqaDGJA0TafEnkJd1JXrJ+acueRATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1NrmwYvUFSaPeMtRStRIcPn31hNUz/oUr0foacRZVQ=;
 b=AZ4i9Ha6YHSlggmYTH4LVxI/u4EKMlsdeGa2Pv+rrHMB7v3rgV9CrxLeiK1SukZbqtDda13dLX2K3Ud3Z6GSmwWi3MfZqIMEDdi81PV5uOXolZ89uf/2ORm9inDyRuqFqc8oizEKtuseoNNWBnw3AtyotNwJlhcYMLDnI0UGwgw=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 10:46:18 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 10:46:17 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Topic: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Index: AQHX4twBpu9E7jx9w0eTfQRflv+fTqwaU8Qg
Date:   Mon, 29 Nov 2021 10:46:17 +0000
Message-ID: <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5cc371f-1594-47a7-ecb5-08d9b3257938
x-ms-traffictypediagnostic: PH0PR11MB4790:
x-microsoft-antispam-prvs: <PH0PR11MB4790863083D92693D3BD32CBEC669@PH0PR11MB4790.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcyWd3xJ3s+THzVZYQCscNPqFLdnNQ2FIZ/DGZcgND/pvE6XxQ+LPaKSasLnD23Eg3vYYJVHqrA4c0rfsP3dlboIaCZyYwEKsCJuiUBWn3Ioycov+aXXdbxLUJFegoT88I263KJOBDG7qrYLWNytlc79pSp6Oom9lGN4gX9zPxXyqxzqo/PzjeqeBMkthPNs5PWum4bXgO1MzZ0j7Qijj2YrZn/gp2BKjbZzaEYfcVMffIVYQ94O67dcg7AHCVEYLHoLh0m17GPUNPzS8T0YjN18Qzi/Ch0JTtF0BeeXYZQJ+B/0+/uET3Fpt0GQmjPX987RoqfVWUlGUO/csmYerjopphmwRN/XTwohlYovzPVQHZetfjl6kh8V904fYnBXx2RPVMPk0axV6w2pVDxqh//y9gas5Bz7cZZ9IJax/3QPsOxdzGIAuVWf0ey4E3Eht0zVgq0AUywDMqttpKAv+4k/lokWi1cF6rA16mBt7zYSY/0p0d2c1Ys15I3IHbvSH4ppF/1vkfX52agSURwaB1cl9XAJRCfWPBbYSj8kpOt5ePRhMxL4wCTZI7AefmvwAVhwgt/7MGcpCD3c8bnkDVzxNWQ1lWfA8HkHHtE/ER/k6EJ17Je9f1dlARxc4mS4DdCOR+n+qJSNY2hXZqwncVH066UIR0YV5CscHPo/X1vq209lWcs6GDq2szD9FLjqiMIBJHCUoaNHFN+3EPzMWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(186003)(122000001)(8676002)(66946007)(2906002)(86362001)(508600001)(4326008)(33656002)(26005)(64756008)(66556008)(66476007)(76116006)(7696005)(38100700002)(38070700005)(66446008)(6506007)(53546011)(5660300002)(9686003)(316002)(52536014)(71200400001)(83380400001)(110136005)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5JBRdxW6xR5FMoge+9d90iuvsWeOpEbOGXTzxUpG8lUU9R4FYNpEbLYIZKwh?=
 =?us-ascii?Q?eYOd4+E/5uuyrS4GfOwJQ0TNTuGeWIJe0qQUty1eeNbYpA7vYlyjw6GoF3WW?=
 =?us-ascii?Q?UZp1LVtR3hqtp0Ax7AbRj21RPPzc9PDsEzjHE0rS6I/IrWckyBTxIgfXvmSV?=
 =?us-ascii?Q?5SJ/aQ6T80+WJ3kAiX5dOdpXXfKtzhJIMMIryKwNF70r6ltmjoT7o3i7sa9T?=
 =?us-ascii?Q?ffzGgWi3mPLEr5n99+2DE/9b3x6sEWmhhBfgAzvDj89v+fjRPx76ZmFusXxQ?=
 =?us-ascii?Q?UFcgx44oCRRq6VAaLlt8CYpaOqp3lcdqrSxVlIfi/pDMWSHaFuAs+mMq6+m/?=
 =?us-ascii?Q?mfyNj7AzvoaNdi+Dvk7YSaA+HJC5QXL2pLBvt+ThJNYX4WOdKZXMEb/XXDVb?=
 =?us-ascii?Q?/9iquEFdQFn2YBfqepVrZ8KspcDzr7ehkhhdKx0vlYg4rKLQ/4yJD6i1uRYb?=
 =?us-ascii?Q?jcB8LHYbH6N6h7dAKcKxZKvgBi2d3Ap1CMO4/zay+bc5UxyZEhTqsnsRL0rb?=
 =?us-ascii?Q?+J3HzqkOITk/kCbhNclPduHmEZhDqf5yAq7FomCfzdoN7q5OS5FNlGnIiKy5?=
 =?us-ascii?Q?GxZmcM0H6DSyyY8yjrVpp89Xx7WA4LnSt3TkRhFfYBCX5OGhscespQjkqAqP?=
 =?us-ascii?Q?uhVLOfKwSkCBOm9PVLjvRdMQbfQy0an1ZXbjN/kUtoLELYrs/RvvF6N8mCCH?=
 =?us-ascii?Q?An5q6Q5bw2Ra3Y5C6q/l4H1sHw3bJYibRAl0bFl1XYdtzmWRp6m1Td5WzQyl?=
 =?us-ascii?Q?tNboWrT5SieMVNMomJ5Q19FGdf+duNhhJ78W+WcRafyzAjjXJqBXNyL7cTzd?=
 =?us-ascii?Q?xnA5+p4s46TG/h8GFlwmiH8cnk9qM77dlZbuz05v6x1uvwM4Rh6D2dH3Mdiz?=
 =?us-ascii?Q?gMG90fIL10d0Vv2L8FL2OB27RuYoegr85cY9Bww9/4it8puxVVGF1PCQ6PE6?=
 =?us-ascii?Q?9vBAfDt6r18bjGlp+0KNhfLm/mpZpzv12hv7rzuFbwwhJuhYMfBMvyMk1ogv?=
 =?us-ascii?Q?9BRjpytf9qX+qGd8zLZ9E86xPam2ap9uNh37jr2b6zbUqKYYKoiUrQV8QK+X?=
 =?us-ascii?Q?x35igJ+iEvC7VRNKaXGSwR2I4Z6eB7Tvx5LGqm5TtjvJiRwOfqRS4IGRFqwI?=
 =?us-ascii?Q?ktKatPIouHRkyB5zqrApOHT7EYS994ze5AEsn/hz/KAPTUa0eIWWyGQRwWJg?=
 =?us-ascii?Q?l0DlcsJQYt5p2F1EwNZeLurkz5J/Rt+JrTL4CLs/QgQGxF3mY0x94t1N04Gy?=
 =?us-ascii?Q?djwsguAVC4tE+rdEBUuRjCKhwlm02JhV1BZyFyhqYvL1JW3ArYO29x0bgmuD?=
 =?us-ascii?Q?t699dx26FIBFV30zpIqO7RRC2iaPWWou+6cDYDnvEhNZX6J4RCEffSkF+n4i?=
 =?us-ascii?Q?z/4jKIwsgd5qQLdp8y6TbhONk+GLgmci4MTE9LVxApPWvH7s6UyCeeRsi86R?=
 =?us-ascii?Q?hZvmqCPaGfd48GveqPpcDyMKEKjRphHlFdyH7AESAE9dpvEIsH8iS1sMY5R7?=
 =?us-ascii?Q?6/YnlxgemSrkBicmt9dLq3UHDvqhrxUrWVmq11HWRG49+0CIjpq7HTOUgUYS?=
 =?us-ascii?Q?Jd96kDsEPGoigNXyu077HDrUKgwEgG5J+fbtxgLXNHfdK64aPcGssiMk87Wx?=
 =?us-ascii?Q?75Jqu5tO/83MUeMvY5r37oYsgBUk5zYrOzxYA/Y6P7zORz7VczxBK9QZ7iHK?=
 =?us-ascii?Q?DG25PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cc371f-1594-47a7-ecb5-08d9b3257938
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 10:46:17.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ly+mUom2bhZgKiVe0M4kb679AOi5JS4RznBAtdCfhp9U+DLaBErAptsXqGJxwvugeiTdL+AA/kcvWj2QnfVOj1Hpb2hGVtQJL7uPeyL04d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John for the update. Based on the given issue,=20
we never tested on arm server.=20

Further arm testing will depend on the availability of=20
the server.=20

Meanwhile will do further test on x86 and update
on the observations.

-----Original Message-----
From: John Garry <john.garry@huawei.com>=20
Sent: Friday, November 26, 2021 09:06 PM
To: jinpu.wang@cloud.ionos.com; jejb@linux.ibm.com; martin.petersen@oracle.=
com
Cc: Viswas G - I30667 <Viswas.G@microchip.com>; Ajish Koshy - I30923 <Ajish=
.Koshy@microchip.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel=
.org; John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

The driver supports a "direct" mode of operation, where the SMP req frame i=
s directly copied into the command payload (and vice-versa for the SMP resp=
).

To get at the SMP req frame data in the scatterlist the driver uses
phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken, and su=
bsequently crashes as follows when an IOMMU is enabled:

 Unable to handle kernel paging request at virtual address
ffff0000fcebfb00
        ...
 pc : pm80xx_chip_smp_req+0x2d0/0x3d0
 lr : pm80xx_chip_smp_req+0xac/0x3d0
 pm80xx_chip_smp_req+0x2d0/0x3d0
 pm8001_task_exec.constprop.0+0x368/0x520
 pm8001_queue_command+0x1c/0x30
 smp_execute_task_sg+0xdc/0x204
 sas_discover_expander.part.0+0xac/0x6cc
 sas_discover_root_expander+0x8c/0x150
 sas_discover_domain+0x3ac/0x6a0
 process_one_work+0x1d0/0x354
 worker_thread+0x13c/0x470
 kthread+0x17c/0x190
 ret_from_fork+0x10/0x20
 Code: 371806e1 910006d6 6b16033f 54000249 (38766b05)  ---[ end trace b91d5=
9aaee98ea2d ]---
note: kworker/u192:0[7] exited with preempt_count 1

Instead use kmap{_atomic}().

Signed-off-by: John Garry <john.garry@huawei.com>
--
I would appreciate if someone could test this change a bit more.

Even though my system boots and I can mount the disks now, SCSI error handl=
ing kicks eventually in for some erroneously completed tasks.
That's even on my x86 machine, IIRC. I think the card FW needs updating.

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_=
hwi.c
index b9f6d83ff380..0e2221b4f411 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3053,7 +3053,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha,=
 void *piomb)
        struct smp_completion_resp *psmpPayload;
        struct task_status_struct *ts;
        struct pm8001_device *pm8001_dev;
-       char *pdma_respaddr =3D NULL;

        psmpPayload =3D (struct smp_completion_resp *)(piomb + 4);
        status =3D le32_to_cpu(psmpPayload->status); @@ -3080,19 +3079,23 @=
@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
                if (pm8001_dev)
                        atomic_dec(&pm8001_dev->running_req);
                if (pm8001_ha->smp_exp_mode =3D=3D SMP_DIRECT) {
+                       struct scatterlist *sg_resp =3D &t->smp_task.smp_re=
sp;
+                       u8 *payload;
+                       void *to;
+
                        pm8001_dbg(pm8001_ha, IO,
                                   "DIRECT RESPONSE Length:%d\n",
                                   param);
-                       pdma_respaddr =3D (char *)(phys_to_virt(cpu_to_le64
-                                               ((u64)sg_dma_address
-                                               (&t->smp_task.smp_resp))));
+                       to =3D kmap_atomic(sg_page(sg_resp));
+                       payload =3D to + sg_resp->offset;
                        for (i =3D 0; i < param; i++) {
-                               *(pdma_respaddr+i) =3D psmpPayload->_r_a[i]=
;
+                               *(payload + i) =3D psmpPayload->_r_a[i];
                                pm8001_dbg(pm8001_ha, IO,
                                           "SMP Byte%d DMA data 0x%x psmp 0=
x%x\n",
-                                          i, *(pdma_respaddr + i),
+                                          i, *(payload + i),
                                           psmpPayload->_r_a[i]);
                        }
+                       kunmap_atomic(to);
                }
                break;
        case IO_ABORTED:
@@ -4236,14 +4239,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_in=
fo *pm8001_ha,
        struct sas_task *task =3D ccb->task;
        struct domain_device *dev =3D task->dev;
        struct pm8001_device *pm8001_dev =3D dev->lldd_dev;
-       struct scatterlist *sg_req, *sg_resp;
+       struct scatterlist *sg_req, *sg_resp, *smp_req;
        u32 req_len, resp_len;
        struct smp_req smp_cmd;
        u32 opc;
        struct inbound_queue_table *circularQ;
-       char *preq_dma_addr =3D NULL;
-       __le64 tmp_addr;
        u32 i, length;
+       u8 *payload;
+       u8 *to;

        memset(&smp_cmd, 0, sizeof(smp_cmd));
        /*
@@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info=
 *pm8001_ha,
                pm8001_ha->smp_exp_mode =3D SMP_INDIRECT;


-       tmp_addr =3D cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_re=
q));
-       preq_dma_addr =3D (char *)phys_to_virt(tmp_addr);
+       smp_req =3D &task->smp_task.smp_req;
+       to =3D kmap(sg_page(smp_req));
+       payload =3D to + smp_req->offset;

        /* INDIRECT MODE command settings. Use DMA */
        if (pm8001_ha->smp_exp_mode =3D=3D SMP_INDIRECT) { @@ -4289,7 +4293=
,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
                /* for SPCv indirect mode. Place the top 4 bytes of
                 * SMP Request header here. */
                for (i =3D 0; i < 4; i++)
-                       smp_cmd.smp_req16[i] =3D *(preq_dma_addr + i);
+                       smp_cmd.smp_req16[i] =3D *(payload + i);
                /* exclude top 4 bytes for SMP req header */
                smp_cmd.long_smp_req.long_req_addr =3D
                        cpu_to_le64((u64)sg_dma_address @@ -4320,20 +4324,2=
0 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
                pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
                for (i =3D 0; i < length; i++)
                        if (i < 16) {
-                               smp_cmd.smp_req16[i] =3D *(preq_dma_addr+i)=
;
+                               smp_cmd.smp_req16[i] =3D *(payload+i);
                                pm8001_dbg(pm8001_ha, IO,
                                           "Byte[%d]:%x (DMA data:%x)\n",
                                           i, smp_cmd.smp_req16[i],
-                                          *(preq_dma_addr));
+                                          *(payload));
                        } else {
-                               smp_cmd.smp_req[i] =3D *(preq_dma_addr+i);
+                               smp_cmd.smp_req[i] =3D *(payload+i);
                                pm8001_dbg(pm8001_ha, IO,
                                           "Byte[%d]:%x (DMA data:%x)\n",
                                           i, smp_cmd.smp_req[i],
-                                          *(preq_dma_addr));
+                                          *(payload));
                        }
        }
-
+       kunmap(sg_page(smp_req));
        build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
                                &smp_cmd, pm8001_ha->smp_exp_mode, length);
        rc =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
--
2.17.1

