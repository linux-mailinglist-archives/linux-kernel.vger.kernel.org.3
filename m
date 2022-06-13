Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635D054A235
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbiFMWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbiFMWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:43:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AE31228
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:43:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdgFf014531;
        Mon, 13 Jun 2022 22:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zFIMLTnVIQRuVkB06MnFRzYEoodCE0aGsG178kISBpw=;
 b=m0+JBL17bcHMqTqSLRHg3cT3GUecjkr6JEdUxZ4rpGcTVE/KrqoWDeQperpULAzuIUgX
 KHmE2QcQjCuzMp3y79zfw2/d0FvDTRguS6+dy2wAS8wGGkbKEAdXPlOAbJlITS8ZTPdk
 JfPQfpUMiZEri3YN6NiLlQWj59KkB7JCulDyC5Iw5/ioPNW2UVObU4VYRr6FdtCwEdCr
 HL5fRm3voRLN6FEBsGkymdeeuB+4CBvuZ9FZuFilVUrUyNwka5Rj3KLsBY7/oXNE64M7
 +bZJg90IBt/38l4UfozQRvYUkHUwq6O12l63Yd5Jyb8wwRnz1PhXjEXyFXXd6c3Pvuth LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktcaf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMehqj014918;
        Mon, 13 Jun 2022 22:43:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r47h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp5IsMF+qHIhH5RL0/5lSc/FWv3lW7bI9MbzPXUMOjfEGdB5GaFlnFkL7nPz/BOjGxHOWyychfB+RkjgcOtAp5KBrrS0qU+mqtoKy4wfVbAoG77nYuRFPeqKOC0GVtWWcjAAxrFyF2o+PoYhIpA/m7aNlu6Yv3pSQgoaObrFZTiouWjqcP5FSTnC9GpAFsE+8aDhrmSU64XmM+evEswqVnQ4ZUucC419c13WVj0O5Qq4GOulbxrNbJI+FdFuHLbMLkVGhZ9TLDc1LO3mfJU7WKBwI5rZJzVc/3BRAQSXBahG07PLv0q/YSGGKHA2rH1angMBpAz4e/PInuZwrOymcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFIMLTnVIQRuVkB06MnFRzYEoodCE0aGsG178kISBpw=;
 b=HISIC9J6fHD6rGLfs8YI8PSYoMfZY7SjbTVc4AvRbvZTfBPMhvoxrTzFzi4BhhElIJmY8XzkICvNxWBIsA+aZFkvbihX67lBgSTNzu/Y6+QLJnIVyKkmnumV3Vj0z9yh9Yv0lmdPU/trobNNsc4qluXDO8/zXNcPU0TRMWGEu8hjwZRAG+2UwqrbIae8qkJ3hwNvOEgOqbESMVMIB6Lk+snaUlIfLPl/vSLN/kLBgrLLkw2fZFo8/Eb4TSiFSkeuHNwvYJBSpfMOhs3oiyxiLFfvx30llzsSOYGH4LVTH8LQgYvIHE3pEwPEiZd+Xi3UgjuyGiX39tTlIjhG1iTRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFIMLTnVIQRuVkB06MnFRzYEoodCE0aGsG178kISBpw=;
 b=GxlbQP6yU6ggW28YT9+DZV8JWPxogJ4DBGuEIQyRrzn/sMrsiEWvnOJoQGs7wSLm1giLXTAQ1FrHjHlUSAS+0tpKQgqWWOGKkF5Fx7rY+P7pI5hJ9ZNP26jNpwh5rAsOEEhR0ZLLIWiMHmYRqWJMp79TyvJH3tttLdU0kyXDV4Q=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:16 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:15 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v9 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Mon, 13 Jun 2022 18:42:39 -0400
Message-Id: <20220613224240.79400-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e2ca3e-6500-4cfc-bda7-08da4d8e1abd
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3824FBD8C95BD8DECA47592097AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+TS9IRcRGC/7F32Q36QSCCIHJD/3UE50+Pj+bgaTR6aposucv2kLp4zJG/Z6eDVG1v6Tp5DEPbMtnCrL65q2VVIbh06gHrzDL9dHVhZcCr12wmpkt3Gn6fo4AD8F7Cqgu39DOkx80Wpi42jxUIWUaBvR1x/ZLWKvyaXDtEyiYjvKJzjPd04wEfnwUmLY10Q3TJfW4PntiPtuQ333+BazH7vWUjFKrbsL4uQ/rxwqj9JOQTKQkX+WjLE3dml6zbeWHNqtLkQHk1RhESzKLWbDYUzupjoDAhy/4vGs1pCFxpZYt8gkHcPlGvpoiT7L6Q2orOna5XlqKBTN1j3Is6WKHK3XLx3wQmFlSEPqDbZI+Av8uJo9th4+fFZXJL8suoSdWsgRbuGkuFCAdF6QaQd/R5hjw1S7paJooZG9oqJU0wxn9zl7Zr7GyA4EtLtP0wjpFdAuFoQvEe7X59WHpnQDD77BOcBOSW8lCUcDMJKJN5IbCAzuULMjWNtUAZnypDg0mtEySoQ8JeAJ8/meWcvK4MOpCLj4atZrmP0cv4ob7bFChBq5lFLqqzT7xL1W0qyRrg+HY/la0yrHYUD2LPvv0Y1qTXK8hxz2kMNNvJc2XozhbTe4VpLXUHg1Cd9YY31q7BJT92yUWsAjAt2zoEqMSdy2yAkW4DGf2YoaAvMBLGd2LZZzB+lqgBcX74pWLBw7X5NuaZ7sXgSBMBZHFs0qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrQKnTvMNdaCvI2006IW1XCf0k8plQOGw7FL+rv99xNAM170mhDWNl9FlEmj?=
 =?us-ascii?Q?XBGDdse+w+uMgDyAaiL5hbkUAElIQ+0/K7cGZVa5twdAKfkdduzkHnA+vxpd?=
 =?us-ascii?Q?CpYqBqz5eOlqB7HWKkWnjREveIUXvjySFB4mJzRkd+jSNacOo2eRUZMQRu/X?=
 =?us-ascii?Q?Gdw6F1xn1+OljmvupuOVh29rhSMS2GJANpW5jtlcmFUY5dY0Htmk/vH3+IXW?=
 =?us-ascii?Q?TqKip46BIofegvn+BhoU+AeBYNwyq+bvRzkvExSvH6xLfntVxBX3AVFD/zbG?=
 =?us-ascii?Q?R8dnqU4jeWt4AL6WGPXAZaf4iWVHw+R3oSd5Ex71I9GilupBBO8pM3MboQ/K?=
 =?us-ascii?Q?wMVTreSgyF4wDuX3ZXz1T+ihy+jAq5ftqNyKHbg0Bk0pJXb6YDC7kGFcBRmM?=
 =?us-ascii?Q?ZAN+JVuiMux4JBD7tbRDJJc3+B1oTa4jS+npLzSsOpYIrIHgeK5uTNNcpfEU?=
 =?us-ascii?Q?twr4+lEnv99VGSYONmNOXoW+d8xZLCMsazyawSTmS5/UBwYJOe8LH6ipMjTf?=
 =?us-ascii?Q?aEShBgG1a3MB1GUEdr1qO0AgwsbNtM/o9ZukYzBk8xhUqFoS/ysIV/V3oRrH?=
 =?us-ascii?Q?iMdZc3aVvGGxj9Vcec8uX1pIc2eNUCTB50W0Hh6pdAJ/HdjbUH1i33B30F6s?=
 =?us-ascii?Q?JDxEUbWZsMwHBnTq1DkEQXX0zselnH3N5JrrkbJQtGAo1KRIkXIOI6QUt26L?=
 =?us-ascii?Q?TiNd+0MDsAFiRemwy603OZy+YLkCXkRDjws8uChRWm3WyZjad3HRKPR7hgBQ?=
 =?us-ascii?Q?AsnZAeLz4UnbgBH+UlbjVJdeedm4AGIAkH9fUzSwgNU7HMU6rHfmSd429Pbv?=
 =?us-ascii?Q?e0isjUwYF2pliUGgp1Z9UxWQydkoX1KaGZknjqTRAq3wZ7phvFGVYZMeaYXT?=
 =?us-ascii?Q?3mWeH96Xh8AAU9tWMw8JOE/cbOHhzolru1p/scSoXbXpjrymJMwWSMyl0ti9?=
 =?us-ascii?Q?q16dT/JoRmAL6Be/Dd3T+0e6py1OVKlcMroUjjk2uahFjY6M8mxYLhJWqWll?=
 =?us-ascii?Q?XWgc+VMvGHN50h8ONJ9uCVL/GNubJjPnteACBU1s90Rua4luN+dn9AiYEr66?=
 =?us-ascii?Q?LAOol4ffZ/VYySQ2uujOsD8GEMPub+Erd+rBVnTs4rFcRlRETlV83vAmIxlC?=
 =?us-ascii?Q?1jmI5TfHKWocOD6M6cELx4P6anRPtyl31UnvsKksQO3D15xZFLiPegTXRlfA?=
 =?us-ascii?Q?5uzpL8vWlXsHCjquJ29ujW5Ap1i0YD1EYVBBejx2Q9J7/yu+jwRWMEiaGFMd?=
 =?us-ascii?Q?nTeDK7p3tbz9yBJLogK22lr6RsnZQH/RhG1QkqLeOaNyQpVDLR28hszyCWwe?=
 =?us-ascii?Q?UGalXv4a4k2lSkKMV4oGPVk7VwOhNcyEMxiUkgmoadluhXbn2RTmckBZuuci?=
 =?us-ascii?Q?q9w11BTHK+MRNHARu/MAKvjPpUgneF6rsnX1yAB9SGAIcY6HpfqoQF96QfzY?=
 =?us-ascii?Q?eHHHGJrHb8V0ziO3+yhOkziPCLLZk44MekeG3Kmd2bWgcs4QTPsaDQXvb48V?=
 =?us-ascii?Q?sJwFwGb8w+MnTMKKPQqtuQpEYt9/txOnfk4JV9QdnCK3R+40ViTKmtLt1pUx?=
 =?us-ascii?Q?uVbFhtbtr0zedXiKm4JCr2IDjKtf0av77m0IlDLUIZcjNpqsSgh03R4F7yPI?=
 =?us-ascii?Q?pkWTfa5u/jgPbOo0YK7B6vJTIn1Ak/Fv1K7Ue7m0JKPuFRt2JHeU1yHCoEv7?=
 =?us-ascii?Q?gLJ3LDyPf0Pn+rzHP51yd5pYVlpySe7aU3QFen6xpg3gOHYb/Fcpxmul89Vp?=
 =?us-ascii?Q?Di/a7JsU6UwqJyu11cvoWdrflu3kVpE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2ca3e-6500-4cfc-bda7-08da4d8e1abd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:15.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7bni28WvbCIc6JoXDWUcpfq9BIl0rzw+Acp04S8ElFIjiSKGJZbw0DOCkoJnCFicIMvAakJiYecqx/eQGGv01RJReTodHBBMIkWRHMGdEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=966 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: r8h7o0bYVu4OlZjxjOPs9i02cXRGFW73
X-Proofpoint-ORIG-GUID: r8h7o0bYVu4OlZjxjOPs9i02cXRGFW73
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will fail for CPU events, thus allowing userspace to process
cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 13 +++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  2 ++
 kernel/crash_core.c                            |  2 ++
 6 files changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0f56ecd8ac05..494d7a63c543 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..13e33d098645 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2ef23fce0860..2afea3d2c60c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,16 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +479,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 7222ff9b5e05..12fb9106ab4f 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -888,6 +898,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f9b13882debf..9aca8bc26c13 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -342,6 +342,7 @@ extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 int kexec_crash_loaded(void);
+int crash_hotplug_support(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
@@ -427,6 +428,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline int crash_hotplug_support(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 47f667df1c0b..b003857ea85d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -601,6 +601,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 subsys_initcall(crash_save_vmcoreinfo_init);
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+int __weak crash_hotplug_support(void) { return 0; }
+
 void __weak arch_crash_handle_hotplug_event(struct kimage *image,
 							unsigned int hp_action, unsigned int cpu)
 {
-- 
2.31.1

