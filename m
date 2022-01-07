Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7711148745F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiAGI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:59:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43990 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236446AbiAGI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:59:23 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2072SkQ9011025;
        Fri, 7 Jan 2022 08:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aQ/kUExtK0DEicMABoFU0D++En+Sl7kRRTb9ZmFTuic=;
 b=z5dfR42rr96ZtSHd+TYRg8Z/1hLt0KfWbCqEX3daBwY+hjSjth8JLoMYP+7+887ITdQz
 2FqqGYUtcI69SpTgqX7PYghdhJkrcIHNeoCG47ZoPIvLW0KuSofk3nUnoJ6BY4vFfkGi
 XYljbPnvpe2S9Ughk+B9ribzNYoljr2+vR+sLNksNSUK4eIREzBW7PeoaYSFtAKvqZUC
 bZscZA5auv6N8j34YlXaHL4hmeuu+2H7MIu0kAfEJZUjebmHryk2CH+FZbk+qTZwz1Yk
 wLYGk2XLWqbMJZgFzoAvqsWsNRaCwacyPCRaFqzKg+WZk5tynxl/iYTwRTUOF7mQ6wLn xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb9ffa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:59:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2078tOQf195782;
        Fri, 7 Jan 2022 08:59:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3de4vnbx4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo6y8d8AgdVLyrU7ejZjCuln3he0Db/+f5FEyH2oyyouw2eaC72W7RsJxx5L6KVSUm01niNSvOvm8sOxDps7XvI6pjupXef/aPaQAyi3Gl7dmQzgtr/AWyvDP4tcsnOIpnke14nFGRkt123tpx1l9itoDJLrorpndqAG7CzAgaOmoFYbPigBpRQVKMKmq2pr8mjg+LWb9hwKpz+BQReLAlGv4BgIWJJdJxWYWRxcFTBor08LEqg/SXvHZlwhLcBOSLxPq3K2qCowjM62/Lazw74N/jJivi1mEUXef8tOAsYsVn6o7GYc/lWthXK0C6XszxgQDtfrOlxI2f/GebdR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ/kUExtK0DEicMABoFU0D++En+Sl7kRRTb9ZmFTuic=;
 b=JMI2QHnLrncYtWXE6woDAKzajAyFJ5PvqP66HJql/SK+GP/SQYjHK28T8NE97PdMKmA3NcRtFzttLvlK9SvrKcEkhoecBTqdCbR0xWRsQNE+oXdSwqoJYibZ7WoX2II4Bu4yMPWSUbJT01UDtQm82byOfgfsxzLSOIQFYXGdhRO5aNbCtCQhhKab5u+uXoH6DfZ1Gx5QkP/UaewMxkxRtY+YF55ZBwSImVGlXBvv4X03ZBvi4O6dfJjnDnkx05VF/L//4hi9IBrLXzH+MlbnWGTdxUUiGYQ2PZ6T5MUeMABU6whpEJIkfvfwK57XITygtcO69czt90uWkxmEUVw50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ/kUExtK0DEicMABoFU0D++En+Sl7kRRTb9ZmFTuic=;
 b=jXLS3e1TQ1Vnj6nAoa5tnomw0qm5iO+opGpED0wYEvVXtAKivGeC6y3PwM4eFeAhZcgCLAp7PTX7rtZS8T/DX1XBhBRxepVDXlh1K4L9D6jpRMVpjd+NcI8/baBEWtdNvtUMni33jRRUhMm/fp54TPxOPiQ7C+65dKvgpKH6Aqo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5677.namprd10.prod.outlook.com
 (2603:10b6:303:18b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Fri, 7 Jan
 2022 08:59:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 08:59:12 +0000
Date:   Fri, 7 Jan 2022 11:58:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: change functions to return void
Message-ID: <20220107085852.GQ7674@kadam>
References: <cover.1641490034.git.abdun.nihaal@gmail.com>
 <9db6b08837bd6354c8e07a4b1c4bca662091f945.1641490034.git.abdun.nihaal@gmail.com>
 <Ydct2sBt6aB+MChS@kroah.com>
 <20220107065210.7utcwjenvcspydyk@nlap2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107065210.7utcwjenvcspydyk@nlap2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b08617ce-390f-45c3-2d3a-08d9d1bbf909
X-MS-TrafficTypeDiagnostic: MW4PR10MB5677:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB567761C77DFF260B66DCDF568E4D9@MW4PR10MB5677.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBtAOUwkKVvUVzjoDI2pQhpeOoKaSIZbYfS9voYjAviBuBA7pYQ2OWsmCErZS0tErdtJBLCT/UFmELEcSwQRpOcwOeaAUMoZIIXQm0IhMatwz+0MCIjSO784Liy5EEib5/D361AI4WgHlPkckILSDVIw8BF5gKD5/C5md/0UNfeKY6avF+mmV4mrMJnD7SPeOue6tSc7dvWCYlAeFxd1vqVFSpGk5RElcHocAvHIDRu8sC/zaZGyocAPpJaa0byzhamBbSizeonFnq9TWD1t/+yl1duDVIGsSJdx+vl7CF0BREd+fx9pz/1smojZnsKhDbNsYO2KZZg0LpqTdUWFjr+ZPIoObqkh0Tl122ndqxF8HVzHP06mhGx06gN8k/3pw/FakWhPeLiBJ7bs3hqSETzvYXaj8bYvytjPtWGET6oWOp7/8FXRsx14Wu7/N3wezYAy7DQxoFCewN6Xl+vENpNXl0O9j2EObUVxZaw8+Z/TEzTlCn2e4Eh5Ao6JqzuFTkX7fNJ2XlULYzJ3EAsOThMQv8B9YtpMaFoHEqKZTvRCQuy4POn/Dg/XmvFh/H0GPPSi+yStAkuJgCyBl478CHTj6zK8lMP1XcPjXER48M+IF3+ZzhM2r8wZ4VgUjP/rpwdoqcpQwFeFaW6OLZ64rdthoemZbB8Vu2U4Ca7s/mPpnPxs1tdjWsVW9JA+Y/3I2MxJIbKiOKJC94PxgxK/bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(66946007)(8676002)(4744005)(86362001)(6486002)(316002)(8936002)(26005)(6916009)(52116002)(4326008)(33716001)(44832011)(33656002)(5660300002)(186003)(2906002)(66556008)(38100700002)(38350700002)(66476007)(6666004)(1076003)(508600001)(6512007)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCJ7RprRfYQel0KY4n7NP6ineqzjMlZ3HsV3dt19AcdDiEH8JoRp1uqmg+Z1?=
 =?us-ascii?Q?I6ICxainAkVfhIdgkC1A/00ctmvs4pKvqP7+di9iDdJZJrWBvSc2MynPbo/g?=
 =?us-ascii?Q?QN+wKMWHv9v37QU1V93LjjAFterayTwj43rosDhKpQ7ioE0qFAYRDOhI7pul?=
 =?us-ascii?Q?/e8yIEZAPbvtIhEsGUZn3uKATWf/4FkAUzIUI6Q8XlS8fYGnB1ir56BRUjcr?=
 =?us-ascii?Q?Y4xK1COQKfwFz0BFIMvPK6Sa+gaFfQi/Ku3seZ3JnieKAuVnuy9Y+z4ENVdP?=
 =?us-ascii?Q?ZdZuCT503jB6eK+vCyrJDZNWycAdbPqXA7a4X6Y0fOnxoIfryS6a/YqjvSgz?=
 =?us-ascii?Q?YyVRjRmT2KOYKqB/xzOFHBzipQ0ntrQTe3YXNrXC3NXmXDGAtLyb0IcD8sbR?=
 =?us-ascii?Q?tBvoYZuW1MAzMEHrLwgPGfAmdNhsOk6ZLs3RZ3aRAWIgXPyCbtzYR7LyohQm?=
 =?us-ascii?Q?C+CCy46vuiuf+8jzsSZNrGeia279JJGiSr/y/Ii0B6o4dUyNRfoIMsWvGHMQ?=
 =?us-ascii?Q?8dYezhK9BJHY+iC51FSaqFZEmtKBTlEVuWr2m+63o0v1gWpB8CoKkdaw14vV?=
 =?us-ascii?Q?Qj9zGjydMf93QSrU4tbireqslnnRlcpY4RvSe1fXb0D3T15jqMnVFK4KmgMU?=
 =?us-ascii?Q?UU9JLO2COpE5W+gUqUYXdJLjq31nOUnlvGYqpS/YV7dhmumN8oOEQjDNFaVk?=
 =?us-ascii?Q?uBgO6jfuS8XTrT0UrVgyqCGuY/0Vz1y5RUMTXAPHsftT14/p0i3e76bqPclH?=
 =?us-ascii?Q?RNHW43QTgfQwGQat+lpM/WKP8WBy715e/oPNWzvfRg5B8ROkR6iVbTPFBGnV?=
 =?us-ascii?Q?Wa+tbpCkmk8WbPrdfuLZNUutOpy4AN8TasBiPyKP66mAWOJ+a0k7cRVhee7A?=
 =?us-ascii?Q?ectePRVo1RcFdADdrQL3kStVLT0s6D4Sxz5k73dEmwin9HUanG/6QfdjAsem?=
 =?us-ascii?Q?JeYLghemFyKPDTyPVLGte7oct7TLNkL9KHG45KQ03c/Ss71MzPi/6R3WqZac?=
 =?us-ascii?Q?njBuIMi/BdBdQk4uQ8dPjH6Zfr6UwyC9AYAok25uPWEaaIFnJ+h53yMrypXS?=
 =?us-ascii?Q?WcYdrRnKttuf1m0h56mTTOHiTTESGLzPiXJVWXyUCTQTo3oQju7AfLagFHAm?=
 =?us-ascii?Q?NBU5W5i9mbXZFCAD4Ehxzp0VYv6cD/jqdOtW3OZjg4z9c7Wm2+yt6waCMUO1?=
 =?us-ascii?Q?bOIqB/5zar6b46meBvB/0hy/Ep41G0eVbsVb4s5YEpBR2/y/sQJAf14SgxV7?=
 =?us-ascii?Q?5isOXNIivv63K6dVZwkZ8WCRDJ5tmZNYBpQtKa9T/225HGf05m5PlmiIHma6?=
 =?us-ascii?Q?1ONrd8T35zjPKzA7S3rOjrOfVHhorStQf54P6BlZRjnH+RefNAaiBxOWqrQA?=
 =?us-ascii?Q?LrrYnLkg1ys0N46Kae9WW73DWUq6yI20ngV7we+F8O2Q6nYBOlpLfdsVRUBq?=
 =?us-ascii?Q?uQNmxRmIBoLHklc409gRlhgaIQ5WuxREMhFrsFU22AnygdBID5oZxkNtldQ2?=
 =?us-ascii?Q?iinScscUCFsykf1SaLpQwjeLellPlnFPyRgYnBkngD2PV/cAI6Hcg/HCTqVD?=
 =?us-ascii?Q?z4zdEg6R+kkSp9rTFVtWQuO1mhIO58m6rWkU1h3uk0WbLjF2wHYenw9iNDjk?=
 =?us-ascii?Q?y6N12CFZjSEL5jujsXLlw0HEMQoG0ilUWe/TLIylPrDsHjnOBbv/Wz9nnm1l?=
 =?us-ascii?Q?iQtcX28/AgsQEZ05gCB635mLZ7k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08617ce-390f-45c3-2d3a-08d9d1bbf909
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:59:12.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZowflKVK3B8WHVzn+U//OWnkCQOabJ+3rNAE7APDuS1SMApXDc3ImqPieIhCJ4vKVsXpIcZ0tTpfd+jVxirjKPJnZe7j/7b7hmUPuFPi2sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=872 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070064
X-Proofpoint-ORIG-GUID: yKJFybVw2mxn7hzGBebub4W1LnpZT5Q4
X-Proofpoint-GUID: yKJFybVw2mxn7hzGBebub4W1LnpZT5Q4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:22:10PM +0530, Abdun Nihaal wrote:
> Hello Greg,
> 
> On Thu, Jan 06, 2022 at 06:58:50PM +0100, Greg KH wrote:
> > On Thu, Jan 06, 2022 at 11:11:52PM +0530, Abdun Nihaal wrote:
> > > Some functions in ioctl_linux.c always returns 0 and their return values
> > > are never used. Change return type of such functions to void.
> > > 
> > > While at it, align function arguments with open parenthesis to fix
> > > checkpatch checks.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> > 
> > Are you sure that checkpatch allowed this change?
> 
> Yes, I ran checkpatch on both the patches and found no errors, warnings
> or checks. Is there something that needs to be fixed?

You're not allowed to end a void function with a return statement.

Checkpatch will only detect these if you run it again with the -f
option.

regards,
dan carpenter
