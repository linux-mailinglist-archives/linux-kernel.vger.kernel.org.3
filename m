Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA851D2AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389765AbiEFIBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389770AbiEFIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:01:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF567D0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:57:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2465n7fA029440;
        Fri, 6 May 2022 07:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ojqoi6KRbCFhQnhbcNeRXtSyypk2UQXoYV8hWqpL4nQ=;
 b=TFQ2xb+J55OwLcw+icNFuaILAEIpGR7Ct/e0AXPH/8InqpGmGQqz7CNcm9YHyJiyowvv
 DFbLca0IY76lauzb2DvcT6WuKlTH6GRqos6DugsxOTCCbsUVbGOFISwE3eN/3r17dg2u
 TYv55qdpNtWuvvX8MbMUuT2i4U2Zvt6/EHxx+d0ieaeybBjwoMqM9dnnxMj6SGyREWBQ
 dTqwz3ZIhS2C6tjGONkmcd74Uc3+yBoKi9tydLyo0K0L94YSb0zmJ/zReYVTuDsDYeJE
 mL9/rQV9XMb9xw+bChiukC5tUkTePpqKxljEp4c9l2PH14ocOWbjzLL45H64XFz/WiXi qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0nfju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:57:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2467t5hv023980;
        Fri, 6 May 2022 07:57:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujbr5vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXwiiKEIsPoVcgXqh4mvWTobHAXuQq8We+baEOU3hGJKNdNrBqql+sJ8Cz086Ceo8LJamh9H6AuRg9nFUARx5UHNuPcWMutngLtz7uPz15mNKrR2qqN3qvvO9/syX20cOtRqN1O8gbN95Mg/pCVWOLW2ceQFADBrs8lpFba+bqmBFGrELcj8GsPrTYkrpPC0veBjU+74J3pTeKGsjYP6hO3wKn4MJMkZpMjFqDGC98pdfHiEBi9FKSX9L6JFVHD+OiUgq99t8sSw3i3L3XUJGjSWyls5vvl3+O0IUQoPbWiJgJ7jyPPybqT7iBlJWqGgeh/wXV5gLuA+7OAzEAyewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojqoi6KRbCFhQnhbcNeRXtSyypk2UQXoYV8hWqpL4nQ=;
 b=SIho6lgJbvQIzuLuQNEy+DTkF/gIIAQ71nPvbKE/oc2lN+fLbGn9CzfHJqJwd3Hw4f3egByzFhgAOOnqLOfxkO6RiHsY3y6UABkGAC1AbgzA24d0FGViIlUEdXx8VXyxhQOdHLJa2quPjo0TcHIe4XMSUt/ysLScxxL+/pJ6zaNI3/AQLgYgDg83RQn0lJHDz52pMuktZLt6bWczHFmf1+wnt5Vnxp26NeyE7RubkC7mWfwP5gdG56iiRk/JAetsNjqhqzosvfvE0pTrUltmNOStcD1ng1TZTBHmfjZW7v63EuqvqUrXbNEDm5HvkkGOxd4iNYiKM0oJ7Ld4umgBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojqoi6KRbCFhQnhbcNeRXtSyypk2UQXoYV8hWqpL4nQ=;
 b=MuiLFBStnzQaBcVUcHbqifTuBukcCqcbfJytNLWoPG04Z0ZwoTmEYdzptgcaVYKJGCBoBh6TQsz/Iv9vlZsbUurlBlUMmJjuLE36yO+ch0Zf67h28HlEIkadO9lrH7rA/cagLhIsyF5mcicnMDDd7IZwkRjvWwLzbWx2iYUr2lc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 6 May
 2022 07:57:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 07:57:36 +0000
Date:   Fri, 6 May 2022 10:57:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Wang Cheng <wanngchenng@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
Message-ID: <20220506075718.GE4009@kadam>
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
 <7dad295f-2ac4-d6ff-8d8a-17db8ef18c12@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dad295f-2ac4-d6ff-8d8a-17db8ef18c12@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f108737d-a1cd-414b-ffa9-08da2f361568
X-MS-TrafficTypeDiagnostic: SN6PR10MB3021:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB302104564D1E64E0CFC7B6C58EC59@SN6PR10MB3021.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoS2D5iiGWpM+s1kBDdR6piFaGMPfxe0bxIvhaj4RZjKv4QkPq3vAr7suGH28chs4VU7DrqORTMRGarR1sv0Cyl9HUmt1RvYEFXmcQ20r3/W2NOm94QAZU2dGAGmVcPvv7sC5uU1qCfXG7D8htVYqpeHTEYeD1fp/ix4bdOrYGnOjgKmw4UztN0nQAwoLHAfg6pmc1cugdLzGp5Dg+BAw1OJGuHqPEAr+Q96EjE2xxsikS9XrO+WjSZuk9XyXnzOWHj3YkUmgyDsbq72dABSzU31cyvDZSJwhV7Fa0wik7in+yVDYaSgc+AI8GnrzNqQOvMO4T9d+yZzEUfNw4S1ZuK5U2cLPJZkr+8rM8QaSJITsQEnSnjDWaz0z73aLCnMIDraMHkhg10IqIkRUlspSYAPa4DokzdBsWmb9zMfyccTYjZA8cy4XtOSL3zwfM9fcIHtmQl2cdou2o+Se5D5dnKkVvtioOenYTTGMjuUKR0A3/DNt99VS7XQFriYNg/f8wdA8aeMvg+LcT0m9z4Of3morbRujvaoXzdSvq003BQTK3ERw+jAIz7nIMZyzjbfB9X22XPZDj/82wjMPkCDvMhytM+U/wiCb60mIe1PtnuRka/2skE/ZWl9/KGjo91juymUcZPJZoz/8uFENHLzYiXtwlp3cfTvergRNjW/66HWnMrP9opii8plUcjZGqrrEie0MAAnh3wj3ZqJtSy8bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(186003)(33656002)(38350700002)(66476007)(1076003)(38100700002)(26005)(52116002)(6506007)(4744005)(6666004)(53546011)(2906002)(508600001)(316002)(83380400001)(6512007)(6916009)(4326008)(8676002)(5660300002)(44832011)(6486002)(66556008)(66946007)(86362001)(33716001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaGf3RjQYxpElbNvSGEGqowGhDYc0920xU85rCfQ6PrIWg4kOW22vTGATh0o?=
 =?us-ascii?Q?R372nUnkKI67oQe8b0qSY6Qr6a0BlKWuNQKOLZztPUTfB5S+qzzw4CvecDvE?=
 =?us-ascii?Q?bOJC4tMsRyWSfA1Pdu5tCTb/KVRB0tyKK1yyEBbVVpnLbhixhs0cln4x7Hfi?=
 =?us-ascii?Q?4TmPwBOsU4Y18XXkM2trqrcj5Ff4BloC6UANPzl6QadPq2JSVIHhnpfwQMgF?=
 =?us-ascii?Q?gQ/evTAACjlLegg7wbmg3kMxeGv1jV6lnouxyPOWZgphlG7QWz4aHN9f4p1Y?=
 =?us-ascii?Q?jvXjGoxiNpU0ox6EASC0HG0GqQ4sHpU4AE4AEcCWcoZiuWz28NWfMYR12dVp?=
 =?us-ascii?Q?E66JGc3cXhIbj+TyB52lwE/+8GpzmMOKxzvxRXUC3msWIbdZM1XYcnoVxsEz?=
 =?us-ascii?Q?FaJMvV1Tp36GC117mcuTxCuGhufcGxmxqzuAmNRP0taLXaDX4DBO1te1oars?=
 =?us-ascii?Q?aNrMi7cooUf/axIP4tNfz9UvqNOIuIv0K839HKWdp/rBUHeOcSbwt+Ic8c6j?=
 =?us-ascii?Q?WHRBsAoN13rP3KznpYB8jsIf3xRMnLk9W5jKzmO2hr2GFK5aZd/udSq6enxA?=
 =?us-ascii?Q?ticDRBO3+unQcLemi6gGhZ+gPFqYbsJA/vzFe6PyXnCmZIFWFtzPU8zcd6W1?=
 =?us-ascii?Q?JYxXdUmQPq+t1skBd8Frl6RHt12xcD/a6ePAO/Sa1mPDUieIeMM8ZKuaetnH?=
 =?us-ascii?Q?/DhAFgwkn4fFVBCvm7F9Jes7q0HiT30dgtpjD+xgDUUmvW6PVkCLECE70etT?=
 =?us-ascii?Q?VTm7nOXCkkutlQQ1R6UEgnH3GGylHr9NJDPa9RyHaRoTzPVMuE9eEPGrurhU?=
 =?us-ascii?Q?WfUlwqGIIGaHdf6m222DhA9QPMQ1f5wVj/FPo9erS6vCZtrfLLV+ADlHja52?=
 =?us-ascii?Q?QvBIFqYScGlvlQZOYRyhQixtoFVCtWk3vxR+RzHLTjmVQWJ3SjtitY811k5V?=
 =?us-ascii?Q?pxBZ48kADooqsmW+mkIpCOKFLhn++OEKilQ4G9WZV3RSQKX2ZQ2TQanC1gEa?=
 =?us-ascii?Q?WPZl6pVwcN4feocnHufJniTH1LjBa5DI45uL2zQPvkNZRyQkmcQMG4D33eoE?=
 =?us-ascii?Q?BaQHGwh+QhVefNpx0EL/BgkCStOJfzV4RIkyEVNT9NqM7JMwe/AIE8W3UjZU?=
 =?us-ascii?Q?DibCmkqoCtAFsTZAs4zg6zerDG98GhnYzMo6+1wS+nqmBJZu+5Lz9GmfTtxr?=
 =?us-ascii?Q?Jv/EYvDcx/O+thXIjYuN2eG45EmzF2jIdQnSP/ra72E4hVt2ylYAnczFjEM1?=
 =?us-ascii?Q?ItLVJAGyU6xkIlgwFRFOYDyYrzn9pyrO3gm1nptsebzbnNFl1gwOENPlJv3K?=
 =?us-ascii?Q?8SzsJWTVVfp9wQSEswkvteg8mpkjc8QZL7jBmfnRjbHfgHFY26o2icjQeBMT?=
 =?us-ascii?Q?LyDOd5OcQ3ESc0dTt5bHwn2YU/Nm3r4YzsTLuHnW8mz4wWCI3/h9E0UIXa0X?=
 =?us-ascii?Q?0yZdO/DinpwMXKX6QbyT7ttp72osogyo34DguuU8GKkrLIXUWb9XhhiqJvt5?=
 =?us-ascii?Q?Bdg//3xbjx2/oR6U2pfFShOMeoYss7jVdh4T4nwhOXm11QWXIcEAEyJrD+o/?=
 =?us-ascii?Q?8LGIjeEaRhH9wFKSxH6GNkgLxkfMs+0CxFaee4LzDzdTZm0Ox2FMfL+ozRAE?=
 =?us-ascii?Q?XkA5C0Ynml0UKJ1h2n5w5hSGA+v4REgCRhNm5uKYf4BFeYV0p/nN3EQj8qKZ?=
 =?us-ascii?Q?LUMRWVRI3+TekQOe9wcp3EhThtRyGUSrhWKuwqS4fstCu342KTa0P50Ab8Cd?=
 =?us-ascii?Q?aFa/c8bDLXqz8Df3sKem85zDvj+N/io=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f108737d-a1cd-414b-ffa9-08da2f361568
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:57:36.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du1eFbIsC9wlp7dh9L+eGGZ8lFmZROWt162J3K//oNPat2rZyDyAi8UWydaePheQByoLQke1Tg8/JLexjulI6fWrlvg5Blf+wmAxe/MVBa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=943 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060042
X-Proofpoint-ORIG-GUID: 9iJ3IdBTVIkrxx8kJ03CMgRLFxTaZhC1
X-Proofpoint-GUID: 9iJ3IdBTVIkrxx8kJ03CMgRLFxTaZhC1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 10:23:39AM +0300, Pavel Skripkin wrote:
> Hi Wang,
> 
> On 5/6/22 06:15, Wang Cheng wrote:
> > When r8712_usbctrl_vendorreq() returns negative, 'data' in
> > usb_read{8,16,32} will not be initialized.
> 
> [code snip]
> 
> > +	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> > +					 &data, len, requesttype);
> > +	if (status < 0)
> > +		return 0;
> >   	return le32_to_cpu(data);
> >   }
> 
> Why do you believe that 0 is not valid register value? And if it's possible
> then how you can identify an error?

I think you are getting data and status mixed up?

regards,
dan carpenter

