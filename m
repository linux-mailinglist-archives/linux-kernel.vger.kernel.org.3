Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3958C7C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiHHLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiHHLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:44:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428AD13E1C;
        Mon,  8 Aug 2022 04:44:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ASsIT008775;
        Mon, 8 Aug 2022 11:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Vq9CuFXpqxkxTdiH1Rp6GX1s5iqaGDonmI3u8uH8sxU=;
 b=xp8BLbNsZOupEFLCJUvXNhJ0H1+1hNo6D+NHjTz/fTqR8XugyOGL9UYQFLxbrtg1FDlP
 sS0BuxOV/PzYBE4cHgayO0TBwJd0B+QFInqXUFYQA/bLPSRCoicuiGeJcoUEiYa6dqNx
 gZRMohK8386dKmILAV16+QlFgE4VDR4U32FCHPIIBXYEJ1XuL/ew1ZKwJf9ZskxmC9jb
 BWdCfkgcL9hFkDuuyab6i3/ufStqJ6ba4nd6/00BY2yn2NhjDYYO5y/KxqBQKN5DJXgn
 6/O97RkPo7fpmJQ+vFpe7Uqc1ovYX7M4Bodal8vCtNT95h5NOY1+iRWGf0wwFTMQ3/pd vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsg69k7d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:44:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278AK6uZ028234;
        Mon, 8 Aug 2022 11:44:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0n2hjxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLds6F9GozJA1cBu80erypshifyDViTg4VQ4FvYC3vaQxS3HZbmUCxDE4aD6QMmAQLgeb6WdqNyq1iTGMY/q+57NhfLyef7kzZIHOX57zOcgRY990axyx4LXvd704eG/j0KK6KVqA2SPzzOBYitLqnNkmBI+IuuH3UoCKq28yiHRCUhXHJqCk49nAq/AYfEWjzhzN+NyWpz+voQu7DMCmcv84H8pdQphUOOHL1Yrm/BAC5iiVR+zswasRuehwaU85M8ahN2cwszgAvJ+mCUaPld11LeWCq0yBt8si2IAaL3DBLnXZ0dCHoTTKi0edKvxlqBpU7mVaxEBzWBkfrJL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq9CuFXpqxkxTdiH1Rp6GX1s5iqaGDonmI3u8uH8sxU=;
 b=SeOD9mReXUYhb1WhO1xUQA5RUbrchLF3W33ZDb/q/7UTFujSvDffmgOd7Wftr3hqMNIbdtB6mJhRDC1TPkmrW6exh6w+VEQh3Z3t9PW7PWgbhGEHtmGkoFx7y4LWKbMlMizq9RjIkZl7mTvp4Lw3LAlRxtwAkYyZMM9iyaRVJOGnuItINsjZ234NBZBc0GG970MIY2BH66DAYj/3R4upgfjd9j14mRT+dY7HNGrIuDluReOeiFkJvAxkhLZ45Z8UII2eKMRu7TnrJ3gWCAhrIFo2TP3JuxjY6kdK4g2L9P5yqpplTTBzGQJl+owiiZJyUZlC9+wZP2NHpfEEuiCoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq9CuFXpqxkxTdiH1Rp6GX1s5iqaGDonmI3u8uH8sxU=;
 b=RBPQBpCc44YnaH70B/92Dwqg4iBKpLzBTwVvUlLvOUg5WVbrU6vR+opm3J3GfKrCtFvTeupI77UvLky+f5CvwVXTEOlOJl883k1zGlGxpO7E8l14RVclIeVc5+NQBIA0qMViuedPswKW06EO1CoU1KGgZQhhH5F4KEMDmn7ftUQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5702.namprd10.prod.outlook.com
 (2603:10b6:303:18c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 11:44:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 11:44:00 +0000
Date:   Mon, 8 Aug 2022 14:43:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     paulmck@kernel.org, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, nsaenzju@redhat.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpu_pm: Fix a typo in a comment
Message-ID: <20220808114345.GJ3438@kadam>
References: <763d2d098793c858887cf8b935dc35bcdb522396.1659802446.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763d2d098793c858887cf8b935dc35bcdb522396.1659802446.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0006.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49273520-1c35-42c9-69bd-08da79334923
X-MS-TrafficTypeDiagnostic: MW4PR10MB5702:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDHg9AMYbz0O3kytbu8hn9M4aik5nMkqG1/Cc/X3DNYmFHM8BcPZSqSD9Pmu/ZQefNc5JGpgxeqZ9OUxNZIm7b2ewId0IcKsDIEvjr6kuUlCLziWKdjGHChxm/kwO3DnepVrrxGVUG2C1Whl5F/YvxnxTPUvue5NhCKXSAcPAhQ4cEYc6g/vFF2ET84742bnw99ESfjZIiEKWWNCac+up5SJao8dkH4+9vXNRx9+ByIvqdgtEuOE8VvNdxSV2b2R7CgSxWr3dMcjXN5A86dgrs2Mgau/wAwTE8z+U932daGtkwcfmG902nh7bWSAJbwzt/DXuqgpRjN5oW41SSiuZR96mktUrqt/qbYrDzYReXcPEEpsmjtBd9gHL4GTjmoVJr6AoO7UE3YH24pGo7nFr/qhD2putTdfx3y+WexksmHx5N1ZrP5v61ozRFM1w2NWwG4bT6SCQ42cLQCYVYAAua5uHDMTnAnYaSgZBqG5lP9cOX39sLl/JSJtKuV97zkKKtlycbXbNxZrOmSFFvqoEVkSjj6yhMwxTUu9DOpi5Urp9dimD56FsUjHyqIgZp/judj+2dntbIUrXmyAAjw3qR+PPO5iJDrNVaY6oT+tPpMhn7OxA5Y5v4C/agNhzzcYDVlhraCDI1vgiZJhmK9uIC05UL4/C9mLJbNv8Aui3lGCtgFw+FmF1n1Ppi1w0Ss+6C67LzVvVRzawVFbCbgqmFAV9uxPZg1BZxEeZUVIgo+DXl5G0at5Et215C6UtxDx99/Jhzftao559jrVEgHICnTQJScz8W/OTny+jcB9TNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(366004)(376002)(39860400002)(86362001)(33656002)(33716001)(5660300002)(26005)(6506007)(44832011)(478600001)(6486002)(558084003)(38350700002)(38100700002)(1076003)(9686003)(186003)(6512007)(66946007)(316002)(52116002)(2906002)(41300700001)(6666004)(8936002)(6916009)(8676002)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6OPaKG/btq2Um1+fJPCllzLunADDLiIAaYMFJp7UC7ewSGz9Axv7oji7GQ0d?=
 =?us-ascii?Q?P4t/qV8S3/bnt/v6DpkuIRc/Qpuxhscc6XpMz7GxecCTOldCpKMpfK2vBATZ?=
 =?us-ascii?Q?P8HenOadLOoDCYxxzpP1So0Wfb6jM+acIHktv/7OBhYC/HmPPXkRzEDOWV8+?=
 =?us-ascii?Q?4IROIHEawZkPVeMZbVNdASL5E2QgOlPYZAjrdtJTKtaI0lO/NIBhP9X+ymWS?=
 =?us-ascii?Q?w1VJrfIYS/dFlkaq935ZD5JJD5v49qC27CHrEuqDSDdkIcM1VUieO4m0toYR?=
 =?us-ascii?Q?yGsuginqlLvFIQrN2VtUA5hmVCletWn2yT3ZA5xqGx97DMkzngzdM7aa/mmV?=
 =?us-ascii?Q?4u4Q2EnWdnamkceHAxhOXixEoxV59maWtQ5gO6sfSKy0FTvMnGLQjlEIggK5?=
 =?us-ascii?Q?KctTzyDgJN/v0o2ZseZG4lWiz3RlqofiMuHp4UVSbOukD/XJMJREPS2OZWgr?=
 =?us-ascii?Q?0vnSX+JuLtK6E2tjFMq20Z8GEN6Vvlc3SSIS1pRkym6xDNkMPGgU4ONBv6SP?=
 =?us-ascii?Q?9B6SMBAUITB5K1N0JC8wW+YCoQSnjyBoFDuprvjwffR1Rrq5SOBopZJF5FY6?=
 =?us-ascii?Q?qghzYpqXr/8GYfhHnexzBb3UPxGYmlaX8nyMY/FDgGAP69dEcKKRmy2yDkkG?=
 =?us-ascii?Q?4MKbrXHPBMSRgglzvyNDaKtXnfEbhmF+Zdi1xMEcgTNCrMNRHSof0H0uFwCM?=
 =?us-ascii?Q?U1t98/27N/Cv111OPRi4aSL5I/R3TPxsfwZHqMOWTN6hoBtnKqPSz3j5tOOd?=
 =?us-ascii?Q?9DJdDyM77urPxRGj0CYYp5W3abpYEZ2n8DGISxqULmRcOHIDYVT3Sq30gSGI?=
 =?us-ascii?Q?XzskkVugI31Rap3uvibVg5YmcjKeKR85riw1Tp0jRRk1RPJKj7PwUFlW7M2C?=
 =?us-ascii?Q?7p/xELt+fHsUXq2UUNZrBGvXkqWJhVRTzU07/4qsAH9jkCyJVzg/ZPJGKehe?=
 =?us-ascii?Q?0v0Umf6YQarGnKnm3wvgeO/tIL2Amk8vtkcRWfhxdEt1OvT+gaiwm1w9bKU4?=
 =?us-ascii?Q?oeCdU0O8I9ernC6sfCKvsvwxIWjdUGNvgYcfm/kxvlOilplDI5SU2kXDzZyR?=
 =?us-ascii?Q?ZAWRq4DME9GsNhXa5hTpyRH4ULtNgLxpiSQ1u070FapZRgpVStd5LOlt9ghM?=
 =?us-ascii?Q?FYX44F2SetmJOQ8vCSiHCbsNXLLYv3fujAuDtJ3t6jSb8svJkioTvXtW8yY6?=
 =?us-ascii?Q?SbE2qZNprwKdbRq8wRSkJUbFrKEbH8KZfurUhXOjKsADTJrDfPf3j6bGTSsI?=
 =?us-ascii?Q?Mcz83wt7qkpiq5q2owluDmF14HuAGSYhzNi2xrNQpxUHeOj3sGdRt0cqyX32?=
 =?us-ascii?Q?kWMJvOR6Vnx7aNwwOUEk2dLbi+Bp/fdkbUjPjJAlz2CyLxcYCv/wUcIeLVre?=
 =?us-ascii?Q?1MFtV6vp7Mm2jDZ3tOnt1tlgwPsHFGWklqH+cmyqXm4qdICmFy+wSP2WJIiR?=
 =?us-ascii?Q?3yT1ipKuG5OP47wBbMZ/Z6b8ufrV5MJBZI5ngzMl8pCUA0+ZNoqQvqNSFN/M?=
 =?us-ascii?Q?cRjGFZ47oLzAOD9ASGNtMkszRvW21V9NdzyWh0M+A0LuIlu81xQZyzOb+93v?=
 =?us-ascii?Q?dFMF8Iqqlq32st4/Ty1Gp8Y7+asY1fPxtnKuh3MXrCJoEcY2ZDDJtr3MGXik?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49273520-1c35-42c9-69bd-08da79334923
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 11:44:00.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C2cJ4DKBsSbLhqNchq9jhfMYlK+MdXKq6aEAbg9xfQrtfFBZQUfYvf1wDXzmOsXRdWkM5gwlDMRlU67XbjfJHyurZOo0cUk2NsZQ5IwniI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=868
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080058
X-Proofpoint-ORIG-GUID: 0qti0J9njORFrkjDfv0YGVnzn4wAjsTb
X-Proofpoint-GUID: 0qti0J9njORFrkjDfv0YGVnzn4wAjsTb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:15:08PM +0200, Christophe JAILLET wrote:
> s/cpm_pm/cpm_pm/
             ^
u.

regarsd,
dan carpenter

