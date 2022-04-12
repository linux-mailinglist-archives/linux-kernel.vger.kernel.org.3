Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF74FCED4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbiDLFUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiDLFTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:19:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564A34667
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:17:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BLtKoi031973;
        Tue, 12 Apr 2022 05:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=T/urJczvHDv5myBj58z5EDdVGdIEAXtuJOnPWJruEc4=;
 b=Vrjc5nhvQibHYSyyEUcZCLCIIrhEKkLQN7UzLKWqKTAOLr1Fc2oFmu93scVZ900Rdm0c
 tv65su1kNY9HLjM9+l/8FLV/DUQq+bf2rZkJ/RDFK1PwqHYGyl9m7SdInCJcWGF39scM
 jU8te5raKzhcbJjP/4q/TLPc2YHAqRN4k0kYGzqOi/AMaM5edzN4VXbDxJwLZPTeY6n2
 Otm9Xh/XbGtOOYS0uksiBDzc7OadeP7ipqZQNhsqcDfk4Izmz07GIVRTdJ4IlQGAVgk8
 4w2SSMLV3elIHrDCguzkXzhLPTRT9UgyzpwAqY1jtNjfSwwTU3BAWAE0+6abO9iTEIYZ pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd5fw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 05:12:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C5BPOe006131;
        Tue, 12 Apr 2022 05:12:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k2cgu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 05:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPoTrU4GYr9ZwsH7++uZvE3A5rwJpUVIpuzPnGqSGMz0ATdE48st1pvJZt0NQh/hl+25HmfzpiMj1jSFSUf9C428LZ84xCsTp3tHw/ehaSVflC94RveGekbNISq4Hf3VSqid6/EFWUhm1X/+HWw1hKf1j/Yzsim/oyH5C+zFy8WpzbQgafghx8Ap8nxCSzswLvXPY+sTtQemocLFycnTYQ+pASmIfp3sJZbeX5RPnNDDgftjs4xiWFs2umV7mc54DvwBNVZVdkX/xNRRQ9Py+Y9WK01UL2YSqajvSMTnlVs0cKMygb4ZmecwddC7CT8UAzKi5w7bSjSnfZpSZuxAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/urJczvHDv5myBj58z5EDdVGdIEAXtuJOnPWJruEc4=;
 b=AcDOxCkeXUtnWFIKlPgkWum+PcQUPxrT3EH4iH41hFaW4QDbF46nN40f72FR2f/W1+cC9LdmIM+Grp/pZKAlnWzSGfIy4EJdoVhl9eTLglDme+QmNFqXhjwBdcXeCq7RDMnUDGqvvw+zZUTX9odCx6aoK8LBXJS7R7Cjo2RZ4bQNsJ6EevECCB9H32vW4AhXkQVj1AnYbTMQaRx0DKVEw7sHYlgdB8D3WVkOrftGxDQdC9QJY68tD4IKHEqyD5Tc4ZyM6cRoY69mS1OYlK6q8MaomUtPEpghcL1jKk+dqlgwvyUMM5HiI2juWnK9PUOnqF94isXBjzgbqzdXv1wXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/urJczvHDv5myBj58z5EDdVGdIEAXtuJOnPWJruEc4=;
 b=L1SjuoFpGw0v739sk0Y2XUhFeBVXyqccpv4uKN5+rmeUhW8wVN2uH0Id9So+vdHfUuwF2kPOdQiCzTArx5jvLnED88bfoPfsuISLWbe7XL/t6f/oYMwCLT5gXrk9iqVcChvjgkxH02cFslCnuI1hnX0ks3b6aUsRyAqwEOOjlP4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3339.namprd10.prod.outlook.com
 (2603:10b6:5:1ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 05:12:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 05:12:29 +0000
Date:   Tue, 12 Apr 2022 08:12:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: r8188eu: don't set _SUCCESS again
Message-ID: <20220412051217.GL12805@kadam>
References: <20220409151557.207980-1-martin@kaiser.cx>
 <20220409151557.207980-3-martin@kaiser.cx>
 <20220411101834.GW3293@kadam>
 <20220411183918.4mw5x6tatslii7mg@viti.kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411183918.4mw5x6tatslii7mg@viti.kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb7ce8c0-3327-4e82-5c4f-08da1c430a52
X-MS-TrafficTypeDiagnostic: DM6PR10MB3339:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB33391FDE7B126F93BF0FF8208EED9@DM6PR10MB3339.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJqJfuSEmltzwpB1h+Q89ieEZL/gledONYe4PbU5A867SzmzIHhtIZvCE+1Tm5IzTS4WOEHLJrLLWTF9pQPH+x1AkEPuQ3U6z/7vX7U/huxERODP2/ziraRJaWc4PXpo8b1Yv1wvQGopZbpr+SRiw22s5NM6q+4DNIuWNzndtseilpSpqMnM2f8g7GDbSqHdohlKCnuifZvFF1bf6Cccxt4xIoHnOT5K17aYRkWXLBq8EgAvvSBloX+Nv5akIBy5u7qF+4fVnoTt3PmFgcbS9syUiqzWATZponh7G87EM3pmUugHr9o2Ua2fj5u7UPpEvV6dWOcipZjUZaDuKPI60eaJJlPYiPVZdE9XdDZi2AHPdlfmUmLPSRYaypmuK3vDYAyoyurKb+ZrifkX5VahizK/u+G0IVpXyiSUBOmF+Fy9dldXhKIbgCxj0YBA06pr0zvm8dKcpzgD/Z3xJn1tApH6q6q8XmX9nRBLLxA1+twa6+0cYxCR9yrE09nt/8YdY827oi2XM+hmlobvsHkt3cqOY+QAIwtJvA/aKzVKiZKcpaUe1mF0DRIsF/QCOlkh/zZ0IfsJz79+XlAJdgZaqNNx1amWP9R4oJIG1RBuVAQMEN9N7L5KFM259qNvYB1OAeHRVUxai4zLPQ9g0QiNZzOe/3//vbErwQtN/QiMmEkpDZ2Pj9NJRlrsLm7n0g4KS8l6peYYViDpWAOHCNIm7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6666004)(6506007)(9686003)(316002)(38100700002)(8676002)(8936002)(6916009)(26005)(33716001)(66556008)(86362001)(4326008)(44832011)(5660300002)(33656002)(66946007)(52116002)(186003)(6512007)(4744005)(2906002)(1076003)(508600001)(6486002)(54906003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aj5fcvLEVvTzJdhk4Enj4OJor/uu/DD/pCCDrEEALYXW/PTRnUSKJ1yaSAaE?=
 =?us-ascii?Q?ul7HfuNYIDqIlHj3mMlHfMYtqJ049hQuoVqLnk1AsFL3ZlDNiDBc/oxcVUH6?=
 =?us-ascii?Q?Qwsw58jve1+XCqjSw4+6Gl1Y+mUKg+ADW0bNoJD9xz5pbVmoSdVO/xuZlYvC?=
 =?us-ascii?Q?Ql7GZB8+Jr3kIwSaKgBFSQgVmFyz0pLdHy9ukauazsP+l5nb5mQN/TX2x1DJ?=
 =?us-ascii?Q?k/qWfJ4jTCwMUI3K1KmJwEdFfnMD9DAH06PLUY415123HA6qifr4WscQ4Pb4?=
 =?us-ascii?Q?taknUQGGiLMuwqlqyGUhJrJJOCU2+9oQWKVYu5Ut+fvgeTiUNNQTxqXVtlVQ?=
 =?us-ascii?Q?7Dg9KeftNUDwmE9GQDptwRkaT8dXTM6StoBhlpe3HfSVPBho13Q5biTpqc9A?=
 =?us-ascii?Q?AUT9qpouWiv5zrZaQFU/bqdY5bXFhYOqi/do5VRF8f9WsQC8Jzv/eiz2/Ly0?=
 =?us-ascii?Q?rGNy4YXayZmBqPwSWtlDsQ0X0YXQZDGfk8enMIPnb9RH9GQ93gv9nPsuXi2R?=
 =?us-ascii?Q?fUen+WSm3/FTdhzP/ocxKbnDPAX98vRlLBth4AkzHB8srf0N22DP6w6Mkdm8?=
 =?us-ascii?Q?4+HmM9tS7ekIQxXXA7KYzHAvJay9V0ozMAy0pzs62zwa29BLgU9LRgupHveI?=
 =?us-ascii?Q?nf+NPU+eShTqgKPGp82Ec1+kzkSOZ2PQk6CucXP1kMQYyrlXZ41g1swqM8tg?=
 =?us-ascii?Q?ZDBCrseny0PPfHru9Wo2RTXfZuML9B57Bs9X2ZACEyd5BajO41Q1WPMCkZRi?=
 =?us-ascii?Q?S5rXDqKlFX4Wn5wmSBTGKhuHRHBZoxMlovTuVfzLbyzylFnvnkxJfDLgNLCM?=
 =?us-ascii?Q?pisgA5KdlultY3bzpqx9G6AFhywSu+16sJ5JbD9ppOPlxqZfFwwIv8mdgFXp?=
 =?us-ascii?Q?1UIBOVRH8JF2RQT1njGFZWe+hK1oNlV9TYQU4DTPCUF9gvuedSd+9ymqmAC7?=
 =?us-ascii?Q?dWjNH3D3jYY0itmsGy9QZMur9U5qbzalfTVnU0eLB6Hne1madITMRri3VP2J?=
 =?us-ascii?Q?7eEJyFDegZS+dxJBbNWzg3puK5Y0l8MH3WN8LVaJHownjbd3SimdjuTN9nLM?=
 =?us-ascii?Q?6DWi6+Y3st1CF8SJAVjdN0XLR6eM4TjMiABE7XrIphNHRxHP/Fd+7E4pWk/y?=
 =?us-ascii?Q?qoTsPlVGTS4jDjgQbD3QS1VkCQCs5zaI4YbPBrHX3BuDmwXg0sNs40XlbSOv?=
 =?us-ascii?Q?7O6TlbqIZ3mrfR+FXBw5SI59N86gP/6xAcguxodlhh/EX9ysqWEP1SYTqOv4?=
 =?us-ascii?Q?Ehrf7o3jdSsSNR2uX0K0CdrrgeS5K32UvqW7Oc3ckMVYYPf8fVl90tGAIyaN?=
 =?us-ascii?Q?/QxIhcYNr63xrUW5QliX4ZSjcdyhedQcPj5Git9q5cP4XS/wXv0+vPuO8Q+5?=
 =?us-ascii?Q?NJ8xXf40xozwf2TNs29bXPLkc8Jx1ODfSl1yrIX6sidmT27P1DdIJtm6+L2p?=
 =?us-ascii?Q?CJtlrqjHlKxLzPgaoAZV1GSUUn9UBPUXOCGQ5Jc7LU6JnVq26hzC8O67Y4yN?=
 =?us-ascii?Q?+tFaQ2O7JM6QG1vwuIhIfRb+VqtxYnHxgf/YqqaLcy4JHrNehXrPBWzDGAcm?=
 =?us-ascii?Q?EmJjd6N3FGYcpUCuIX48Dk59QE4zgpiP0g+1kJzf+WJ8Mu73Fopc7zAsCwL5?=
 =?us-ascii?Q?jQVEgACHLHbyvJZCw7Au/+xphNktEag+v0o2mCUmfco8WuksVufVhGPYqoZB?=
 =?us-ascii?Q?CcYVioGtKzAaOfQzR9t75nHUGQsxHYm8uz4qa7TorQJJ8hDARdxXapBpfF7i?=
 =?us-ascii?Q?BLwS94OXfDU5hu2v/MRwoyoeQClm94c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ce8c0-3327-4e82-5c4f-08da1c430a52
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 05:12:29.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FjuuYw/2XDClEphgrGK64KTGe4Fryz+aSH3G9IY7Q2vrqqE68euXsXanHX/Uh0AWe5Eo4sPb9B1WuZ8JJ+02n1oxT8ARpft2G0TMhTFB10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3339
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_01:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120023
X-Proofpoint-ORIG-GUID: 2vFuVH43Ngy6EoKGNiE-hHsEIIENtPT7
X-Proofpoint-GUID: 2vFuVH43Ngy6EoKGNiE-hHsEIIENtPT7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:39:18PM +0200, Martin Kaiser wrote:
> Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> 
> > On Sat, Apr 09, 2022 at 05:15:51PM +0200, Martin Kaiser wrote:
> > > ret is initialized to _SUCCESS, there's no need to set it again.
> 
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> > I liked the original code better.  Otherwise you wonder, is it
> > intentional to return success on this path. 
> 
> You're right. The original code is easier to understand. It's not
> obvious that this check should return _SUCCESS and the remaining ones
> return _FAIL.
> 
> Greg, could you drop this patch or should I resend the series without
> this patch?

Martin, if Greg's already applied this patch then just leave it as-is.

We're going to have to go through and remove all the _SUCCESS/_FAIL
stuff anyway.  This problem will be cleaned up in end.  No need to worry
about it.

regards,
dan carpenter

