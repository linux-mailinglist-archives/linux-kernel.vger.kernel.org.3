Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5623A4A6AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiBBEkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:40:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41028 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbiBBEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:40:37 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120iBHW004739;
        Wed, 2 Feb 2022 04:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=h5jGeIAykil3n1iWVAvcNzprH98WXmhTFags5lg0dgU=;
 b=i/0DCeCIfeWaBHOfdmN+wdauTeZsOOzB74D2A6zMAko5JP7/pGV24SqK7bsyvEmWkdi1
 hJaFITKfPq/54A7px3awwE2w12JIG8ETRo/f1F0MeBlg/yTTEHYL1UOXvTtk+x3dOxkI
 7XNH+11V8KKrAnAK7k1jOxvscnWlrBTRz4z+Ey2fk8xzz6gL5jGOg6y/CK86aCTjZz69
 7PAaUrXr6+KZQI7bchs40ANAyD+B+ZxTMfHOJNINRb/q7478JHxWcrKP1iUA0tCIU1ui
 D6xzv3ZZ9B61x39Dyc46UWaVuN7haUtkOrM4PIiPA10BcJMqcZvUQF/4QEfcaEPm4W8w Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4u72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:40:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124VPq8031471;
        Wed, 2 Feb 2022 04:40:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3030.oracle.com with ESMTP id 3dvtq1rda8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im9N9NY5pC+Ma5I6DkKlXKhVQS+x9xFnmlIEWpqxrjUdtLHI2uqo9oMuNIdEmdq1xrebhGZxzzGz1Qx6HTytWqRKRvFkQmihQAdTYaokPai0ARTfmKam0Ji3cO89FWScb1KUdkl6Lb8RgnctpcgUndJmuYPq6yo89gSaXUg3OM/y7hLRqTcH1XyQNEcKPSk2tXQKlufWlM6X/t3RiJzI9Pkmr04khKvnwhgZSZUd8I6HkX8jIuLczWmgmmgdtxOOk2OiG6Zee6VEXqJYnt/HWSqcuPI0Vt5ECFJZPnd3guNpr5ybJR6OyzY2WxFEswguHUz36fx6VKzrw80WQib98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5jGeIAykil3n1iWVAvcNzprH98WXmhTFags5lg0dgU=;
 b=OhywxFM1RVR5M/Co5DZpdY7KKBgN4tILwMCVjfcJw5HUe4QnhmZP8Sd2FRmggoYstvFDDEgIN1U58s9jF7m5AFyF33/40OMeUIPz+EOuvADhE7KHjY7CR3lMQYks5J79eFhezWmN53df8Mi+gjpsHT1w1W/+dohbaeKl+FIR2O+wLdq4D2U9f8So9Ld+rDVzacKJM+a7HJuvazcEJfQYFvAk38kqk/w3VINztWwyQIOTcOpFPcy4/ylfvQ63HryghuBNPe0wqefnSTbNoavktrVRItCyfNYLcDW8jg0BgbJAASbrHuIX2I6ZkjavwocbfKqnmaXo+bH2cYaKrsLaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5jGeIAykil3n1iWVAvcNzprH98WXmhTFags5lg0dgU=;
 b=Xq8vi0JX6hyyavgECR3af7Q0HJVm5OcH6UrCj+W3dxGy9fvzF9/NN02avqT+0bZJE/FXrkdjNQFucLiI8Zr3bxdRGJd7tEuAf46VwEE/gj1Fw3Pt3qUe9jMbTJ3btuokvrrbspejM/p3G/l4F2R0RiIFLjiFLuwmEHqpbzByVCA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 04:40:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:40:24 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCHv2 3/7] lib: add rocksoft model crc64
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1iltx51b1.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-4-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:40:22 -0500
In-Reply-To: <20220201190128.3075065-4-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:24 -0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:208:134::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6f4623a-6d60-4b0e-ac4f-08d9e6062097
X-MS-TrafficTypeDiagnostic: CH0PR10MB4844:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB484444700A361A188A3A777A8E279@CH0PR10MB4844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNhbgZi9sleBQ32NN/Uw04eWgcbW/jHK+kjFtZSwgMOGsIM1G3WilHdItD0Pshqiw4TeeRhoKZR1bqPsG+yuI71/P7t/LYUKOpHijnPZmXi2eY3qM8vFfn8p8PtR9nj/ab3kGHnhGmF7UyvYUyr8ivxPEE+9M5yu/IoXXAWJqL7foEd0n010XFLP1z6M1Nj62hwxOMZJwGBd0/2u9zmhUcTydmUMwho9AxuhrIT0WFGXn+cAgrHtReQjToQwmmnrbRaUES2hLWv0wKFn/WdC99tzJN50rp0JsH1NGRh4IqDu3B1LJPE9E2ha5Jf6H85M0Y2RJw9ZHJsPUVs7JT7VDB1IWpHpBHW/Paz5POdfeTXx0ExE/3mHUElVk2WeKvzZ/IONjpXUsBzvshcyPYkknAKhB4SIUFc5HRZH3o47L+sA14xdexqedlXXEVERt14xTTjKv6vyyH7/0eUOXoL+0tKcGRftD3ztqzEI+w20O8jM/2qK0rvAcVtGDIfn00PE4g69aftrAnz1F/jfpdMm6Cnyx9agyA11rnDEpyyDQse2Oe/8L5QqJMmIw0UOjDx+8VYL5ZTYFTM2usMuUnSAcfkf8pzWfR29tYHEydsFJJR4T6PUHHzZ/z7BPuzEeUXVJUNCD5mG5ztzBFL9dkRRBjgm34WIpyNzkEyDkqTtJ/eg9Ef6LqstP9xD0mZ+yEAX7ztMC3ehOYu1Hk3vTl+kYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6916009)(316002)(26005)(186003)(2906002)(4744005)(66946007)(38100700002)(38350700002)(66476007)(6512007)(36916002)(5660300002)(4326008)(508600001)(6506007)(52116002)(8936002)(66556008)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dK2Rn190udPf8FVZhPPtZwkaOSETKTkwT39CMVgsfCKOMLv921X1MHXd2Zd?=
 =?us-ascii?Q?6qH5JmtY2aQFqMKm23Cfm9J/8vEnop3doojxXpda5mVO8bMTBK5AKCcg2DxI?=
 =?us-ascii?Q?CR30lPLKS7VfxDqwMIcTSqEHWvXXj4defhXoEKIvy1qhJhM1i2IZvUPyG5Uy?=
 =?us-ascii?Q?UhiTO79h46mKl3GG5EJ2xJsXviluF8YKEwLyq69hsebltYMND8ZDWgHPYwFR?=
 =?us-ascii?Q?A2m//Xwj76kUOoWx3mUa7CmHPUr/m1qwQv/eTN/HqQYO+9S05ulKwE3S747e?=
 =?us-ascii?Q?xyg+iFaN0qlO1cpFQyXr1kUqnMDhXg33C4XP40l/krnRXaQilCf6Wi/u128L?=
 =?us-ascii?Q?JgHH/oIavELz1SfbdT95smmI4QcM92i5wV3gLcctrFSj9eywAgvcvQMBcO3r?=
 =?us-ascii?Q?7jqKg2W5UKTX4EMh4UEV54NmRQ3cVWCWHCxzIRQVEVRGoBgRpBc1VyV4htfq?=
 =?us-ascii?Q?a7he2gSIxD7zGcD1JVMxvJKQp893dl4H/cJId2thS+vkYArd4Mr3IWLliYoh?=
 =?us-ascii?Q?Pa0gnQJzl+cGl+q1jqTs50eaaGU7IdegbeAghPxSVLw+tfVvgqOUhglMCxLi?=
 =?us-ascii?Q?b2IevIFS2/N6khkecGnv/YPMpUOi5bTjWTjBITItio0Z0L8i44LTWRtNIum7?=
 =?us-ascii?Q?smSlyZN5wE27fDGyqrPqRxdQAs3fthfdFntfxM8TP9Yv1ZwwSKOPev89hPMI?=
 =?us-ascii?Q?yseLbc1Pj28z/6LW3ImoSKJ75SSb0rODd6fe8EQi3IdZzn5GhfajX7se/6aB?=
 =?us-ascii?Q?ae6y9Vbvy+5tiWfxpijONzkuIAx8yaDpRCvWc1E+Qi9SjYV3OPMsC+Rm05Y8?=
 =?us-ascii?Q?wuwihDUeLwmmut2/oWwTo1Jnn1C6VJ6/MNFd2AZpXbQkNNYBLvZaW+vIP4hB?=
 =?us-ascii?Q?PZy1OiMSgJ04XXSkzanVabcmv+le8h4VBSbfRGB0L53v877b2H5C67LKePaf?=
 =?us-ascii?Q?aH8IDVncl5XST8PE6sR4NcAIClg+Edx2dKHHRFqVS3NBTiwqRl+l3f4TtYLP?=
 =?us-ascii?Q?Y1zztjrXyPKVGWUGdlJlc70ghhGKS/PwiZ1MoBIAxXK6BVU4RGOYvXvS+Rne?=
 =?us-ascii?Q?JIU7ihUTht2jn+5NSVNvApj5iiUdQSs4zbJOPbOEyUm75JS2/GkUHpjn8U7K?=
 =?us-ascii?Q?xsjqvXFO/aBPfadN4DCoP1O2EO1IZCuWHE+tD1xyJo0Rjmx3ClHdmrAsriMO?=
 =?us-ascii?Q?8UKBZTsWczBxaTETaG+lfWeDWGHRWOLIrUH2xNfL1DULFChQ+BEddFIhMd7z?=
 =?us-ascii?Q?ocOUwnd6FzK2SMtcDPAwunSze2P5Qj6ydVsguN+yGSy354uTUA2sd8bEsfzx?=
 =?us-ascii?Q?rfo7r31Jacpyy08WkDWkNcy4wCnaDSCJhj5pIYn5pZ5j1AC5hm7GqQhnQXkj?=
 =?us-ascii?Q?YVh6h/6KRWJwk0lUCMsm0HmV7tN76muJP31Y9xuwYpRBi+b+lSg9leE+Ytko?=
 =?us-ascii?Q?UgFGUhwwZE38CNWoK/hGy8i7dnupFN3aGVuQ0pex/c8Km+IfQb1aRVReUSRm?=
 =?us-ascii?Q?klR50EWCEZVlWEMQRVsc1MlZkDzb3IDCz9TFpeZsAGNprJZmveWXadk2gSGK?=
 =?us-ascii?Q?1YDgaUjBonyKwHS64Tfi4/q4At6ynbZu5iVuhGXBJNsKzq7J/aoNbD49t4th?=
 =?us-ascii?Q?T0wlOgLomlyzis18QxPp89DtAnXcQiBU8oE2M/wPseQ5u2Ags9rtJ9xpNyuv?=
 =?us-ascii?Q?lXSUU480OIsy9LTWMIPbr3TTbZM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f4623a-6d60-4b0e-ac4f-08d9e6062097
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:40:24.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWwt7D6I9AjmAOi59h+AZn90Q0XCepw9aGzNzmsqWgIFOCo+1oyF1obyvMnAaNUSSupp3qJetfTYn06NQwOMp/phd7A3Q1pcuV+FhNChw+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=859
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020020
X-Proofpoint-GUID: YPKxDgwoaRW1AZWIcHxixoHy2xLjO-W3
X-Proofpoint-ORIG-GUID: YPKxDgwoaRW1AZWIcHxixoHy2xLjO-W3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> The NVM Express specification extended data integrity fields to 64
> bits using the Rocksoft^TM parameters. Add the poly to the crc64 table
> generation, and provide a library routine implementing the algorithm.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
