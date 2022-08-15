Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68E592C70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiHOIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiHOII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:08:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F11EAE9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:08:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4hbIE027834;
        Mon, 15 Aug 2022 08:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=sJBp9oFEXRvTzo6Xvq9bWhlqRN9kCtuKJn4WqfU5o7A=;
 b=a0i4SCXhGEpHTtbLtq+6X77OEesZujaEmJ7BCOBB3lJRb1wuRPjdJwTXHFgpwXteg8k6
 ZhJkYf0Em3K6Pde+zC23YFeDXlCUajN0UFdxTj8nMDi3e2L0VqmNXX0YWHcz0b+Pjk/r
 brhE3WIvlzHrYxf9SrFXE6qiPUXb/QqIdkzEA/VrOufKAyZnrJQpKNT2slIdwSKagWLs
 zxI5trYT2Ctwc4WL420EEaJ0rrGXkNPnzLol91gIG3ED5hO4mvhzmb6wKJrqNJWcuGr1
 fm00b7X+8dtIt6aVQB3fLR1QqP0h6pYhRv551liy5kphdymiZMDJMAwfXCAmth/8WCwR IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2aetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:07:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F40QpC032463;
        Mon, 15 Aug 2022 08:07:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d7prut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcdbjEcksDehZy3kck+Qv8dKiNtYXQKxZNsHlbGemWv7Q8ZmnJgGNJdTRlleBKo3Ow7oPp+GvCPcznuPf/e4GPsveldASrVf0oySnjtq+tl/VbrM9fkssfxo1HVTgsCWOOmIa3talcpM5fwBz8d+W+aklIH0YH1lRJYE9xVwDnlD8ZVHwYQjLTdbI86h6n6Jw7/M81NiFPPMjqvBW5/i6ItN6jKnryHKXNoaeuKd7jwg0nNPapiGUTp1PJuL1xuyGbHhByfZsHPtr7/1+tDjZeNTX29pjeDLmbredxIHeLtcUlmff46FbD0ckh6wGcZAtX8khvwtsVHCaqbR1pBWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJBp9oFEXRvTzo6Xvq9bWhlqRN9kCtuKJn4WqfU5o7A=;
 b=B04CaCI1f90h8KQY8MyhRPXSopAONB1dBtQ5Z0wlVzwjB4KrBd/Zc1NQMbxpDggXoAYPglzPcCjKBfoFlENEfIO2aDyOXTDoLi5Gr4vdg17ESK7f2YCN0g2lsu2uiuf0RbPAN/uFYj9oG7jR94CDU52t7T+jj/rgWs8bawj3KCfwC+SlJ3Z113yjPNI8Z+VWDzq4111HLixQUkFd6Q2ufOHR5vBxy2HSQ5WKCE9DfKQvxH7EuaWy0UUT2d9G8K3s2VgD0mXJ6/4ldxLboKrGRrW9IsCHEQAYaN74ljYRNYX5YpRbUQpJjVejTU5bdgd9xe5i/8E30J3/I4vRCa07FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJBp9oFEXRvTzo6Xvq9bWhlqRN9kCtuKJn4WqfU5o7A=;
 b=yT+VqvNfPNtb5SRTGOsWhKgiiehfePrZQXVSvCIR2hk1YY8vT0gTFDvzJFdStNgqADa/uIr9VRW1QAhkW99WJ4lw3aSSAWGBqMhyad389rQrZ9hxfpDjn2X57Ea2elePHeKCcUkWXKy5YXa4iZgSF9ysiMobZTQWCKgkdW6avkY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3626.namprd10.prod.outlook.com
 (2603:10b6:5:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 08:07:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:07:36 +0000
Date:   Mon, 15 Aug 2022 11:07:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Matthias Kaehlcke <mka@chromium.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: security/loadpin/loadpin.c:365 dm_verity_ioctl() warn: maybe return
 -EFAULT instead of the bytes remaining?
Message-ID: <202208141119.RKGSGoZ7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c604429c-08de-46dc-5fba-08da7e9536e9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3626:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbnnmP57suGv/xYx4tETsw5knW7gmomxeb5dKlgut236nXd7OuH47Q2gN9B4e6m4BB3mL9sdwQe8o+rGd2jKI6M0Wj9wNw4EQLa4al0L4AmFPYrsHOkf7vMTjp3hzvB4Ah7Yw1UmV3vD7q7GVOsPaiBMKSe4GCMRxEDKuJmriH8WjP/BjlfLFW0vY51KwmncE7llYaqj9E1W8yx8gL6t13GrJKJMgUHCZ9M9NC3GF4mkjv3ihyEG4DwLpH1Oi63n/TNjX5HjF9VjIbKtqkAM5gHVc1ssu1qerSMfuZf0Rl+rf/4GtSHKIGXmoggAXZXoqNtwaRytvIyqLJS2D/aWIsAGAkTpiMy0MQh0AvvXOPTi7//xYYl80QePjJfC9dAMcU+NCY0O9qTqxTFbCgYCvULAoPkRpGZ4tvYAQeODa/IQwz8nW4EewCAdY+Y+OwmELtgS4KPQOzttLLl86E6E8exQ0/cdMklmxi9R5u7zfYkfYBW1CHOve6jZDqnM2JAYv6dAC2BRfNvBo0GF16XoDJYThA5+ZxQgk72QBBkw5wNvOTssYp1+/rlMYGX1MgEnR/eByJ3yY8vegDc40br2bQ/mur2hGuM6Ge9rk+nPGiYqkatNyC1GtO95RwXmifn7qKX1vzz5TV1SsYdazY4h8/cxIcv6e/n8kIJ0g87StRl0x+mPf5A1Z7i/VpzgCLuodr0KIgOeSCnyzVFwigmHmBz7Fx1sduBTMhBnF+wdP2Wiu8zfOG58sBS40w5mnE9Vivwz2wzOLzCiVguixWjMfDAXXr8OSLU4cska+a/ExH4vDYmabr+WuNfLySr/4RdTDVSjOWhzKBLGTcBkqHtabNWZoOdv6loK2bHzrKMT2VuiquLM4q0xXQ7404zSD9ry
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(396003)(376002)(366004)(6916009)(8676002)(4326008)(966005)(6486002)(15650500001)(6666004)(5660300002)(36756003)(52116002)(2906002)(41300700001)(186003)(1076003)(44832011)(26005)(6512007)(6506007)(9686003)(86362001)(83380400001)(8936002)(66556008)(66476007)(478600001)(316002)(66946007)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFBizcIRKkTTc4AONklPMiaaWo8Rxi30jatoJCZwuLNEp4kjlsnBMmaUoFpA?=
 =?us-ascii?Q?fi6OuyGFaxuWw1tN8JDATsD90WCRtrXFU2ppYTicIKHHuffrK+JIU6AQ65Xi?=
 =?us-ascii?Q?1vqaC2L8fB5X4nAMpLUIcq9CYGM6by764rc6mXCOH49zEgr0VLhJlP8STm55?=
 =?us-ascii?Q?27Vh4fT+Jyb5AZwE1sTnDM85IAdVs/7hVMSoPRI4AKy2RvoMTAL2AZ7yKBg0?=
 =?us-ascii?Q?/0BVl+8oj4GHz3FTDJuGv4+bV737iGrVdmiy9Q4rXW1+9y9PpxpdbOE5hZ2g?=
 =?us-ascii?Q?UHSWokovreyzuImFtPKNa9nrg+oYfj2w1ho6LdLqpldMk3DJt1AD5R7bCCXG?=
 =?us-ascii?Q?x2/EdJrPjK9P4p9SNzFVqIXRf0bm87m2klTPPaJVIpLAlCjjL404GB78UwtC?=
 =?us-ascii?Q?i3QxF2h8SFhyIfuAjRkhcaP6P7EHZi0iNxNDkndYfgBr8vuTepJIQamfVRu6?=
 =?us-ascii?Q?KnYJ9dhg5gnzq/ULmfNH/bG0BMoo0eijB+X/wN4lEI2TOSLc6BGcdarhQIrU?=
 =?us-ascii?Q?iEVyF3yXNKCzzk0mSauhIqMzUS2H9YrKM0dijt0if3Yr6WXC3LuepI3SNaXZ?=
 =?us-ascii?Q?XDiPwgXjnaIR/YteGSo3b0gp6AvwRATaRK8RLqFRubULmR+yo1Vfbi+x+kvd?=
 =?us-ascii?Q?eCE2UDOpzzcJbWtgEVj5+rmfuZ0G847vJEzt3WdbFfknFmAVWYc8OTxJJ5zw?=
 =?us-ascii?Q?FA8xM3/833jkV0kYccv839uShB6Ia1LKaGF11WITFDTs46SCuwV84BHzh3jn?=
 =?us-ascii?Q?pfE9yYOPXl6QEl7prICcTg4bgap+j+FcagpzI1D+l5ziQyfxsYYotf7Queee?=
 =?us-ascii?Q?zmBc0ylaVmHa7ELvqf1tHF+R61Ja4fyZ1+Jgp6HnBphlJZu4J9Vn+a2g9/rR?=
 =?us-ascii?Q?1O/YaeWGGDGQ3Zf0/Nq3jHIMTtQUgUd5TaBCNuGaisDuKtANelwUsKr85rRq?=
 =?us-ascii?Q?5yODyQBP1d5IjLJYur76nZPRto6ZehQjHoEN5+VbFAxjD4C+iEjrP24zrbGF?=
 =?us-ascii?Q?yUxNGgSua7dZ5757WznOqUTHmJzu8EAKMru4HjeunqDcyoMET80eAaK/g8h8?=
 =?us-ascii?Q?Rs3EvlE3SWmRFfV/t5FACBG/jJV51dxb4j1wqnfsnzGBd1ddUv08xgS5CdRA?=
 =?us-ascii?Q?ZfpzwHd450QkikSq1mPylF+UDoJSZlAhxwshotXLeh5jZTUGNJh+gStT3oUS?=
 =?us-ascii?Q?HEzIUM02sEjApajwjATeH6n9Gswi7IImOXiqVk4FWxbRqOmf/4CSjImQkIwn?=
 =?us-ascii?Q?FNJmtB1clD615luSSrJoz0EofEX4iSosnmKCb1lq25OYr6DpcvAaaE43qnqp?=
 =?us-ascii?Q?wB9detVKMGs8ajMRJ6DJdENPwQIcshJQNb71WsQviT+yL0UEpXknc8Doa1VI?=
 =?us-ascii?Q?UuuLj9qEynv6MxoYuekjAcvsHZYCaADltuNtwTK7/Js92G6EH3MLnPKPD+ch?=
 =?us-ascii?Q?H8n7QfQvd7/bz3zpNu+zcoEVyVPeapp9ekJBgXrpJjjMr8P+oqLwOJ9Hqvlb?=
 =?us-ascii?Q?C/hKH5PmnaGTBRLlpThZSOJ2+lPaTIMVpJz7Ts7qdl/3ztbFKQHCiRaRFGOz?=
 =?us-ascii?Q?bdJQbELrfui6eC/itIJEl1mtPrJ++M5IBMRvzGgCCX8wfYrSYP9q+OMYMCAA?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NWvxO6xlMGj5/KPtHTSw9IAc48BZJa+c+EjBwniovRmF6vC+t2kzKR6Oq96g?=
 =?us-ascii?Q?+DURqQnhewXAPJfofxgDUnvRq+nEQmLcUfraPwxrdxkLHpKpFG/xwuCdKGRc?=
 =?us-ascii?Q?GB5APC/fXmri5bT8zOSGcUvHIrrpvKS4JqvfmrHrGy/JsO73syHoA6WBDD7G?=
 =?us-ascii?Q?urQHmqyn6kgpO+X+gtJ7iEKS/GDG58laIrPO+pnDuOIO3EqBXDY61FXTml3D?=
 =?us-ascii?Q?08Z7MwRNxyoq0rENyOOav4Vs528wR55gupE3NQPiPVzQzshn+Jt7LGpOgD3x?=
 =?us-ascii?Q?HGXD2JhyEHG2lI24fb0dNwuDSXtx776KvCBrP7pl8aA5IfQbpLuCOXTLur7a?=
 =?us-ascii?Q?cwP4snjBVT2gqO+Og6RXY1Rol7t+f374f2AprtssvnfBEtY09kMYgngN/0Eo?=
 =?us-ascii?Q?ae6IpZ/BdKpZcRhElsvdHWTVefKJDIU1ZzveYnwKX/+6BlK62KC8EFlShxPi?=
 =?us-ascii?Q?X51YdN0hW5gS7DYZ6wqCRxTk6SKU81f1lzECx+9BsmLSMIqKpuIXjZAHJD+H?=
 =?us-ascii?Q?JUI6aYvmbD7ZUyJ7ZF+lkCecRr/KJYlBBBILp97RIxiSSTd56VexWjsc2Y7r?=
 =?us-ascii?Q?W7Hg4AnSkJLwtaCQoH4XuAbxvjKX8dR7yH1SUDXxBniwjlDkk0ePgZzfcCLq?=
 =?us-ascii?Q?Mk4oERnxA8LHub64EBcsQqRZcsUwIH9yDSDOgu5fohNp05xIjHd6eqVDBxH6?=
 =?us-ascii?Q?PbQk93YdDAaHMlzZ7cy6RB29Ctdwo7sFB7aUI2fA5tJfuMRkgA9eI4cH9hZE?=
 =?us-ascii?Q?Xcf/JbGyIsmC7Rw3ecYK+p8XM6SbrMwUz+syr2giYenpegAvOdMxt5MV8Pk0?=
 =?us-ascii?Q?IpZMTC3C36HsljLJyagNMI4cslDYZ+WQqnLMHpx9/j5ztYvXv6vockyRGOFe?=
 =?us-ascii?Q?JQTkRw9bUS6H/v8lgpWkJKyJcPWj78DQ5ymsc4sudtiVF4LJ8UPk4Okf093E?=
 =?us-ascii?Q?S4Jdo9iDVRYyjfopVnB+yxgfOWZeRF7mFC08x0Mh1Bg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c604429c-08de-46dc-5fba-08da7e9536e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:07:36.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ7davMHCAc2FQ5TrIY2ILzqAosRbBH7wdd3qObNIe/IaqUsQbViESdEscqCEvNYq9dKD3SgLyVpAhyWOFIy4zHtlUYlKHJCM551S1+cCJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150028
X-Proofpoint-GUID: 3XClPolNHcHdd5DW79mMF_RUZNY_RQ2v
X-Proofpoint-ORIG-GUID: 3XClPolNHcHdd5DW79mMF_RUZNY_RQ2v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 3f805f8cc23ba35679dd01446929292911c2b469 LoadPin: Enable loading from trusted dm-verity devices
config: s390-randconfig-m031-20220810 (https://download.01.org/0day-ci/archive/20220814/202208141119.RKGSGoZ7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
security/loadpin/loadpin.c:365 dm_verity_ioctl() warn: maybe return -EFAULT instead of the bytes remaining?

vim +365 security/loadpin/loadpin.c

3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  355  static long dm_verity_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  356  {
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  357  	void __user *uarg = (void __user *)arg;
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  358  	unsigned int fd;
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  359  	int rc;
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  360  
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  361  	switch (cmd) {
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  362  	case LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS:
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  363  		rc = copy_from_user(&fd, uarg, sizeof(fd));
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  364  		if (rc)
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27 @365  			return rc;

The copy_from_user() function returns the number of bytes remaining to
be copied.  It should be:

	if (copy_from_user(&fd, uarg, sizeof(fd)))
		return -EFAULT;

3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  366  
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  367  		return read_trusted_verity_root_digests(fd);
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  368  
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  369  	default:
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  370  		return -EINVAL;
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  371  	}
3f805f8cc23ba3 Matthias Kaehlcke 2022-06-27  372  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

