Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52850FD14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349991AbiDZMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349979AbiDZMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:36:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE389BB0BD;
        Tue, 26 Apr 2022 05:32:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q8oXvv031587;
        Tue, 26 Apr 2022 12:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=QvniOY2daYSno41g0RGMW3k9FAVfmeYpvoWaLPIKaqE=;
 b=h3kD3GVqVGFUu1R0IOUAN3inH58Z9KHq5HMPj+yt3UWNkKI1uIqphK0cHNeR7napJ0oe
 UJd9Q3z7lfAysRS3yObXZqs0vEPWcVQ0rBAem58okTy6gTqiPnQXl9bMDfZGGkjkTpiN
 iL8TrziEES545Xhw51TTdrZf4yrUxovenCufdRegDtUzX9GNvaaEbQmsteqFk1HT/rMO
 5ZN3cwmX6nojIFfX/cZxspmiylLaesAfg5lGqC9kR+ynXVApnnMs6LgBJwR4+EFovFza
 gNsPx3I+jERTY4GgeSE3wvr4Y4UV91Z7DIaUTnz/bEWZKTAOCWIUuF1BGaEL5efhhuaF ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jx00s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:32:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCU3PC008328;
        Tue, 26 Apr 2022 12:32:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3c8my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMtyZKNBiXgXkuWrSljfm8I0/bJDtDDfkmA1mOvV5rt8Wo9sDJghBLS0qLyGbf8XbciFluxiiojpiwN0O2b9oukOea2Tw24hMEUVufr3tNF/ZStgsYbRAjrPSG/439cl9I52F32aSzhD78fIV7/o/BsaBqhG7N2HfHkvWrLC8JEy4+lSu24DulXJYvcb4ZEqQ685WM5pJ3/+cMFNv+iCTrK0gEMG/ILoh85wZu/C/qb2z2fcGMxpTY3WrpnJHHjgWDoCiZIaVjdM6EGztWfpBg0GI1xMWSnAuKyZuSdPd+iDvvpixKVJTfHZr50cqTuXHT0ZtDySe/dWRGLiwWSH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvniOY2daYSno41g0RGMW3k9FAVfmeYpvoWaLPIKaqE=;
 b=NHE7MvVou54fY86XfEEiA+2DUis6XEexilNlJsd8UL0yovk5VxUj+jnWCCosz/Movv3+voqD3ZEbFaAQw9l0J/RvyROaq7sQMs1cORaqNT0RQXSpw2EDv4QirKqCBUxtcPfqeqRgpuBLDuSyQBlZk0/k6jpQ6uzsSPyQk53zDAEhI5HtcGl7O61IRAimaA9ZRJXvlPC4/S+G6ticUmFSRaSQC6haqTX/sCawNxoxUpETGji71AGhK7YrFhjtDdcgvNZjR6j/06dmVKBOa0JJGWcHJ0DdcF/sDvNglq+o+8FamXzsNJwpaV6EWj1wCkTka70++AuT3834o2oTcuwrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvniOY2daYSno41g0RGMW3k9FAVfmeYpvoWaLPIKaqE=;
 b=kLElLe/rNiTCUg1dr5ZgL0E8TaDntKOhFP09rQYbU70smvviR9nNHp9PmgifhoQpGhbw3sB5LJubgPm6xrevYNw0OX6gpPQ4gvXZMyq+mu57+vZsP9dwbGzShFJZo2ZtPn0ySq7bbgYFLThschn7uZyspaewaPXSocK/XKe8qiM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 12:32:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:32:19 +0000
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Subject: Re: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuagt48t.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220331012539epcas2p180d804d9562b6e0fb968ffd181d64605@epcas2p1.samsung.com>
        <1648689845-33521-1-git-send-email-kwmad.kim@samsung.com>
Date:   Tue, 26 Apr 2022 08:32:18 -0400
In-Reply-To: <1648689845-33521-1-git-send-email-kwmad.kim@samsung.com>
        (Kiwoong Kim's message of "Thu, 31 Mar 2022 10:24:05 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:d3::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa7231e-2d8d-47f9-8e88-08da2780ce28
X-MS-TrafficTypeDiagnostic: BLAPR10MB4978:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB497889B179918F3F16C018928EFB9@BLAPR10MB4978.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCZkagBL7n88i6xrxie+n+W1FO+Eov7qmtPmvRDxx9qhMxtU39fQK9HiGNidvJNbfckGXX+iX2BO2QGMPk/J/POxQjSHV1/6wbs5pT8NtlEUuMmQi0GfaDW6t8T1JFL0MY7lSaq4P1+jgn/cjyNRbfQeGyqzBKr3Jl6KbvauVu6ZSbEXhMSyY6FjFtHznbGhJmvB6ntzCL0wXC0cUatYHL1pMZkqgoqhJTBJpFJzOwafYMxwsuJzdycfL0f7uubiOYcDUKNHoBIZaibzRhlTgxfsD4s731mVy/wOc1igB0iqtLyc8GtcRDrs3c8hhEjDdTiEGtRwQBX9illbkQUOz7Geqb8o06R5KdsNpsq7emCWk2KiF6zVc++CUgj1GwdMLQUjquxyQPWUEGkZF1Wb2KB1sFx3XLo03WWals2WL2SdW82A3TE3B+X/6veswAJiiI+NX9GgKkPy5loNqoQb2+Ittz4AWUBOuMtbCpP9XRQylPVoDA4sl78tQIS4lFxqNOOjEduqFISVQrmmSuN4JDoWLDrOqRlVWRIP653TPzeLsDf8E+CPk9SJg2v9dIYyQzcPUzo3Z6sRwL4fZ/fvqQyjVCQA4AzAoDq0MuJMKY4vULH7XBtBXBK/QiE2WryQkzKMrrS+0KTBW90gh0VukCmnHBN5zwIq/kajgDuXVCr5J1bWkgo0PZCf9O5Lno2Ck73JyyvGGAu4mnZiKS2MkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(2906002)(52116002)(316002)(86362001)(38100700002)(36916002)(38350700002)(508600001)(6506007)(7416002)(6486002)(558084003)(8676002)(4326008)(5660300002)(186003)(66946007)(8936002)(66556008)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xN5cn9bxc254rDKZzIWq6QaSAc/VBcO9KS76Mcvuprh1lHpcZlhhSwmkz4hz?=
 =?us-ascii?Q?dO5C4fyTeMO1v63mOcNu36Dmc3I80qR8UxAyFtgRFrNnoWaGVPkpVa1owalQ?=
 =?us-ascii?Q?9ZgYBUzWHw+H8cDDxYrEOzLiw8nxkGtGis2lIZRihLJwyzLK6JtAyLGk/I/q?=
 =?us-ascii?Q?TNXQ+xGyOOtZAzeVqMqNMyXRfADV0QxYvbFBKmWT/CzBilRyYxEkjClLUKdl?=
 =?us-ascii?Q?I+Aq/JTAF9os+Dcmg3JE4bk9OPZknSwj2361arPGIamqyBcP7s+QHP7cvizM?=
 =?us-ascii?Q?B2ek8ppCn/tKn2TsTO1Zmzv5nrqFVRH7byrirTJPTSqwC+0BTqICfJXNeZ6v?=
 =?us-ascii?Q?3b+P4mDDezJnH9VZRNciAXguvHImqmHH1LzcN/RxCxcKRDl1WrhdjSW5WcAm?=
 =?us-ascii?Q?qCM7NTb1dbpMlLiFjZoCdS7DGDxjiPHz48TdZBd87aPqtJQTVOAPblfCIGS4?=
 =?us-ascii?Q?6Y/YjIDOOOzCuDB+Hh3pOKiMq4sT816rXGpUahMpybaruIPtN6soY1Qfjiy8?=
 =?us-ascii?Q?Qd1BgFFlEnz8GvNv0W2mD0WTabsOYqtE2zX7jmauf9QSOU0IMWmTKxxJjmgA?=
 =?us-ascii?Q?xqyMooiA2fB9RpuQFpyXv+CzWalqe2fTdEpwxwth0S3J0KRZOBJqCr+cfRWo?=
 =?us-ascii?Q?52p80VOlgr9j0JPj/33L7Hcv0ADH2lMOXt+V1LXhQ0MbBLOD7zl3Op7OlDVL?=
 =?us-ascii?Q?UolS1KPZkaNq6IpkgHhn97TAopdlOs+Mq5fzq+0nAH7wp2oJkmBQTWYFN02z?=
 =?us-ascii?Q?LMCVONX3JCOwaMl+NwqK1QXCHmiIJul6wj88QM8Gk+Tts4h5dtOxYuXij6nX?=
 =?us-ascii?Q?Dgw5GkSlsUXz4c+Nxmt2x3N7EDWkMJ0eA0BLfZJLmIG5Yldz5xIRpOfuUH1L?=
 =?us-ascii?Q?Sl2KNYX1Ot0PvCHT7tqPpafce2+NopHDAT/hk6hqqjTrjG94R9/2LAenrmjt?=
 =?us-ascii?Q?X1uuLTWLwmW9voKs2eC764R5JZyFWxyOgtURbuFUEY0zUimFoDalHY60fJpd?=
 =?us-ascii?Q?7SjW9AEvZBTyYPEUrXUn+GOhMSb5yGUXlVGuR5bPU3dj0qYaZX/eDWgSzeVa?=
 =?us-ascii?Q?96442S4FzGCwXw0ozirfwKs5VOBGGpd2ZPidxljqptvRhgSPDugf7h+YOPdQ?=
 =?us-ascii?Q?leVgfNzDJhyrEseNlFzynzIvu0mznUWmzspsTqSRSoYTNJB6o9MOkF8XGxiR?=
 =?us-ascii?Q?POJr+Z1xvQNE7kqaJ3oCkN+ukVs1ePFjSx312PXL3tSnV7TU3tDwx98gZwBa?=
 =?us-ascii?Q?9YyVKf6i/Tf3/ai91LltYIVeID9zUm5+9/djlhgEmUsMBwlQEMlLZVUtfTpg?=
 =?us-ascii?Q?73+hbySBYJkaAujjvYrd0B0sUb2GlPOZldY82daHw84s9eofZN4ySffLMkuw?=
 =?us-ascii?Q?QgwbPcubF3D5EaXc6pM+SLRX+saZxn9o0ppfognsLQKbRRDCKgRK9ncSn9b9?=
 =?us-ascii?Q?4Sbzz9BDqR6my8fE+cE5/p/3HT2bwyKsy/uMwAvTl+52WxC+/JYUpgUnbyHQ?=
 =?us-ascii?Q?U6pi5wcWvfF4797MTqu/nPqkoWchr9vReH+XkV9Ycj+IOfBFxpL768yIlDbL?=
 =?us-ascii?Q?dVnpCjTx/5dEvCUzoBcsa+OublTq0KJJeUrnbzazebcHwqr/tcz6K57GHFL7?=
 =?us-ascii?Q?sR+u+NTt7ipHGjsPnRbjr4uvfncgh6zsgquvxZvuuW9JVGvkMozOdgCE/Jsk?=
 =?us-ascii?Q?enhdgOBVtq4pswmQOdxZ3zawx+pUe6IGqxEJ4Jsf7XBijfgJI4ihHm/8i512?=
 =?us-ascii?Q?WdMZhZdG6y9mONal8t7IRHtGN73e2tk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa7231e-2d8d-47f9-8e88-08da2780ce28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:32:19.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9F1DUe0cP3V53qQFO0YQftxaunCJhmRzIubtneoHbqAyVonYa0uC3BaNXy15MnKaTd2DfwKs6HirGZ7u07ucj1dB8aXctHY5SPvC5uveHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=705
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260080
X-Proofpoint-GUID: XvgZSUXe0rtxddo6l4qqG4B_2L7z3mHO
X-Proofpoint-ORIG-GUID: XvgZSUXe0rtxddo6l4qqG4B_2L7z3mHO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kiwoong,

> This patch is to make UFS driver not read those SFRs in the dump
> function, i.e. ufshcd_dump_regs.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
