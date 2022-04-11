Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1244FB5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiDKITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbiDKITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:19:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074913E0FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:17:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23B7bjgY012649;
        Mon, 11 Apr 2022 08:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZuFOHhAi+h5+3TwZqC8OrAhNilb4+6be+K64cvHbR4w=;
 b=HK8J2yJXNonyOjlbiJwTi/MEXWdjLP/qZ+4PX8pcnv4osqLCMhr4Ebu9oPEnav0yd3E6
 FyVrYw301SPjLq6beGHQFOF7m4vBbLAKcx3DAHIbsgsnNeAKEj8b2B5w3c/4opiyyIi5
 GmSJNhmSAA1rnL3UcPCMsUBrhriJQCZkcV9s1rH8BdlU9e8RRKSxFXv80fNgrAecrYT4
 cDycJaUv/ZIvUzURSsTEOf6f5w5LLaqdI9BZ8BKosaBCEyWXJjR3pVem8GIKoJySMCiJ
 Y0egneoWw6pfIkAuF7/5cNpzzs4KHkjz7V8/tN5P+lJweqZTxIshWb8Wo32vUg1IuCkD 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptttby-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 08:17:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23B866Po002532;
        Mon, 11 Apr 2022 08:06:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9g0cny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 08:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOsWpvh5u0YRelTFNqp+oMXaJ0/V8LTqatq2n4+AvyhhY1F1KkARgech1YFxMhnuixXtQXBqDsJZmMzKXafalctHhWF5ujxPFpRycb2sVnq0zR/emlioNBeyd6v/gFShlt+AIGJb2v9Y1vccaYfzHOM7kh2UDvUo32TeC/tBoa9HRz9ExS1675zd9rUwqPIWjXkZ2TsZ7eHR2KuWtdZkizQx96AFcQ+998mzaRVUqdsksYo06aubBaaK0Ebor08gURHdBgcQYQWM+EJL0iY/i0fUsx9Ik+bfdza/JQKRfIH/XPVlTdS1fqGzJFs6vPSiP4IHkkb8xqJYYLGJ2PNdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuFOHhAi+h5+3TwZqC8OrAhNilb4+6be+K64cvHbR4w=;
 b=k1w0PfXlNMgAt6q505z/M9C3qc6fk7Pp++9VjeD8xSP5XHRUiVZDZ3yz/mvTVuDbhNRkRzk/1T1wQrMwwjmbm5LEcABH94Ad51ps1YqwqVdx8czEhDf/B4HlWjz/0ZfUXiDg5HoGvS2Gig7JMpPvwhp7VmoeLmhRIr1O1Uh11f1hZGzoH1ixUuO9M6+4zEYkSPVHIQ3aw2k6aXhUQ/QywZegNZf9y+0kfmh2ST5tl+Xw5QIoKjboyzh3e4o3ldc8hw4AEOcEwPi6PlkUKaeUPRE5BUal+TZH64w8kg0bP0X+82k2HFtoI7t2VH+jlb1CaDKZ7YcebFNcJEYDHLjoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuFOHhAi+h5+3TwZqC8OrAhNilb4+6be+K64cvHbR4w=;
 b=RW/3oxKbpDQEMljsmOnFrrNoBW4KQDuXwPP2SHBmu+L58vyt8U1uFk8UvJ9R55GBmfRjWqnqH2tZdosmPJcMf/cq4iJc6Ruoa/n5kD8oRVyb7Y7XJt1W0EY04cs78MXTOuXrbg8r+7JCPm9V4/f8OnGITXFw47CJ2NUIF25bbP8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4832.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:06:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 08:06:45 +0000
Date:   Mon, 11 Apr 2022 11:06:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/6] staging: r8188eu: drop unnecessary wrapper
 rtw_free_cmd_priv
Message-ID: <20220411080623.GB12805@kadam>
References: <20220410163117.3964-1-makvihas@gmail.com>
 <20220410163117.3964-2-makvihas@gmail.com>
 <783d850ce7778e9d8f203155034e432910553b1b.camel@perches.com>
 <CAH1kMwTPkPV=gLg38m=yq=n1U2Mqa4+1XNtB_5Kc2y7O0mpMpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwTPkPV=gLg38m=yq=n1U2Mqa4+1XNtB_5Kc2y7O0mpMpQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a51bf6e7-1313-4010-eb3e-08da1b92384e
X-MS-TrafficTypeDiagnostic: DS7PR10MB4832:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4832CE0A697D74BA5C9FA84D8EEA9@DS7PR10MB4832.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEcQwFaCHa/4v/nZwVpTJKY0sso8OiEPto4hBj4dPEEPYPrDMO7MjG28C5PdllsWNopcLdizQbpsoU8bWMxII9xY91rZlHXjzSrV8rqeqbGuj1gj+rIF4vIuI0B4rEY6o10lpDF3uNgMndckPMzl5q7KR/2EPhDjirTqkKty1+JaPr6mg8gHApD+J5BtC9Umc9Z7oewfERnL6xbqGtO4L1sIzhOhMRWpdFvwLYLR08PR6iYBw9O5VzuwQ6xIgYR/ew4iaXnhnX+a2iiXXq63qnZwaUnlbhMGBCYXpke/qcGZZovk3FFGNIAn/O6mIsP5mdjwSD/9N5XRVvq4E7Gijkzi9lnOHNKRxUH4w9kwFfN4rZOpWMgekd4LkLe5LkGuCm4LP1RtYMxadwRzPYnG2a7PspOpiTdQ/TzYdy1GOHlnVu+/Ko4ifnVJLu2Rjkh2lK9pysWAAf+iKaykxP01G7D1Z4EBHvuWwPedbXQNINGjEMvCfkHQ4fgWAETSbhqUbe4stQCoo8s6pF8oAPsfwJZIpiw73dDHs69deREZdVL/QrKnMs/3qem48RUlyKiyOk5jgCuoVYuqAD82nHg0sOHR5jE7YdTaGKKQzXYNrV2mNvVxbGx09UngPypZaE147A3GSkT27rD/TC/6muc0s7YgY5SAMpArep2NJzrcd3noZ4AxXBSbPrkYt73Kimoot2H67NIAWQvJm9VNzS5hEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(6486002)(8936002)(26005)(186003)(4744005)(5660300002)(2906002)(33716001)(316002)(508600001)(44832011)(4326008)(66946007)(6916009)(86362001)(1076003)(8676002)(66556008)(66476007)(54906003)(9686003)(6506007)(6512007)(38350700002)(52116002)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q37i9PORp2IQ1a1Yxsv84JTdwv5QjwUhJyixuLztDCmxRnfrWndXgQ61+ZY/?=
 =?us-ascii?Q?wd8WKSFoUzHYan/V3+On6tqH7d8C5mGOD0i/ZCXTiMQpNazoPc57oFzyW6kM?=
 =?us-ascii?Q?qPTq7e7b9b4Lsue11y02T6fiflhy/Vg3GmtyePfURQ6R6siGv1dOlVjr69Ov?=
 =?us-ascii?Q?2MD8jhLrrUF7TlUUuyLKDvx8zraJZEzmKa6JDK7sj9mxsgSTABw7J+IBSYG5?=
 =?us-ascii?Q?t8wb31Eh467MwZTLVqjS85Ptf3dMUm0qNCMQhLM5M6uDcpvQmg94Slb1mxx9?=
 =?us-ascii?Q?gJbJl39Ygt9+v6pI27Evw5U4X3Rfsp81K7blVYpHgZ4zvJQ+jToAVWy9PQfL?=
 =?us-ascii?Q?77arcrFpiQcaUluV9PFMIF3vZyAMZRYkjlxC44lU+LmWNpWqSlRYbAaj0wLe?=
 =?us-ascii?Q?LIrarKAbVqwm/dRD5Hp4NfajbyK+e+qYo7yaOYiC4zVFIb1dDqAHNlIda54I?=
 =?us-ascii?Q?gM5ElOwZyztEpMibCHGJuQvucrjpQ5madNX9lXHZV63WbGOFqgLTqCw5i1gd?=
 =?us-ascii?Q?0jK2ks2KDhPWCoxzMMhxGXoI4Ys3wPKxt9Hjt9YEw9QBbTCzgSmUj7+oJ3bH?=
 =?us-ascii?Q?coMtRmpVOCBTKx1C2ltDG1JIUyt11wTL9o40XFCziYeRk+G/vS97Esr1yEqc?=
 =?us-ascii?Q?WRqz6fTQK8Ufd49do14Vg+P6jeBtUyH4WV8tOqmo5gagx0ni2k9lHqDry5Cf?=
 =?us-ascii?Q?138Hb8+sxY+bE2q9zT8uDpvMkjR1AfqrEA4jnyiGfrHCO/I0B8ImHtO+xAUo?=
 =?us-ascii?Q?T99XO8gW/3pDbSVq1yH/keGWMOE3RkG5N5XWOqW1b8jVzpgXytq7ZQHPea6f?=
 =?us-ascii?Q?CEq7TlnucSP8paqR9VfgA3z6ZGHiniXLZIcCq+LbSCKkcbCjBkE3nmuu2S/n?=
 =?us-ascii?Q?oc1pOubp0tTeZli6gFmK2zyw52+BqWNZCjNs1RZoy+kB1QDUd3/3mc70y0bx?=
 =?us-ascii?Q?bwSJhnyRfAztJmptPlYApnlMQUdsMx1RqPxspzS0bMuqWYdGHJ7P5A+01W1x?=
 =?us-ascii?Q?Jadf8Ak955rEx8hFfGChxesruimI0cbtRgXzRLWbOLX2UowCO/T+mR5D1gPR?=
 =?us-ascii?Q?sq/9reC3opgmSDgDpxkJ81fn4nu9ln9qZSUIs6Yjt2LKG34A4gIb2d43sMyC?=
 =?us-ascii?Q?TCTQxE3/V8TxoE3cf1ln97E1u9tkn2sDyExu4SfXEQOQsEq15b2TUzS8rjwG?=
 =?us-ascii?Q?IQ9RYlUh4YFAJyLY3pIQaA1hbmvUHA7U69zliu1dreaJ1rICQoz3a3A2NubA?=
 =?us-ascii?Q?2RZJ0HNeiXxc5CQUiCuCkv4B+jNDMWA4mEp0ypO+aG2j+FNv0Yd38lkGBJVi?=
 =?us-ascii?Q?K4+f8y/lxFASRUPzhDE+l11u7osmqO0FZ2fwGts5pQh/RNyoaolFak63v2vB?=
 =?us-ascii?Q?KQUm7aN8b0gWho2y7lfGU1ymqccCKDPuQPlIu9YHVJRoNKe8pZGsPJXFISZ6?=
 =?us-ascii?Q?asxp6FLtL3pTFourr0V66uq6ed/a8Ur2ycpQdL6rp5+YyCSzFg/d2sXkx+/3?=
 =?us-ascii?Q?9d7QpsupqptCKgKHmHo00hzcuGGPlPAsLv3JR9dXkkUA6xtrAH6monkumRnk?=
 =?us-ascii?Q?stV/3kxctN8xNWd0MjXNYjdckO6Uwo3orb6xuxxgr/vj+jTkVUafMWTJumOm?=
 =?us-ascii?Q?2D6dQVgb29W/QRkozenNjQjPRAOOvbmyqBAYa+OdWLI54tgbfJwLt5AZXvVG?=
 =?us-ascii?Q?XLNH5TdaefWb/UgN3R053D5XtX1MBwGa8IfxfwKXNm+fZSj21ZUduSg0MfsE?=
 =?us-ascii?Q?7sVfrHIUAvXHPd+RjHjD7bXVqBQ2Bbo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51bf6e7-1313-4010-eb3e-08da1b92384e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 08:06:45.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZP88WLjg79gfSWDHjJcc12qHk40Xn3bbmJMQe3wq0TvDG5/S+c4qX1z70p/pk/edRpvQ1hRLKdE4/LCZJQ8gryE4MBVrT/DutxeisMfutQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_02:2022-04-08,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=842
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110045
X-Proofpoint-ORIG-GUID: 5Pjo6Mha_zrXsFyv4CR8qs9c_gjLyFsk
X-Proofpoint-GUID: 5Pjo6Mha_zrXsFyv4CR8qs9c_gjLyFsk
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 11:08:02PM +0530, Vihas Makwana wrote:
> > On Sun, 2022-04-10 at 22:01 +0530, Vihas Makwana wrote:
> > > Remove the unnecessary wrapper. The logic of rtw_free_cmd_priv can
> > > be moved to _rtw_free_cmd_priv.
> >
> > If you are going to drop wrappers, my preference would be
> > to drop the underscore prefixed ones.
> >
> Yes, that was my initial thought too. But there are already some init
> and free functions in the module with underscores prefixed.
> So I didn't do it that way. Maybe the developers kept it that way for
> some reason.

Yeah, no.  There is no reason.  Get rid of the underscores.

regards,
dan carpenter


