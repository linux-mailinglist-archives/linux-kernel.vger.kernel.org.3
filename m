Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1D4FE474
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356939AbiDLPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356914AbiDLPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:18:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B25E74D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:16:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CE7vVT008887;
        Tue, 12 Apr 2022 15:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1tHth4jUUen9FhPo02GcgvT0KBNbICsSUoUCt90hLnM=;
 b=LrUwwLMNlHqsWNXJqb7ucgf5v7QhtHW9rUt/OVHtTcY49rhNjL1Wxbvo02fUpyNUnxuF
 OW7m4nJBEDqQeP2Wxc3FqpV3XozvTgKpx4meHPgVvU3hKh01ztqKr7VK7/Ev92G4Zb1N
 avQy4iukepAIzH28cS6aNOL/vz/nVxDPZdAoc7B9TJHbUK15TVXmFP3NuJaVEwzSOVj5
 qotK4VtL3Vjr4fdSldiRDpJjHmOZAgQzBmtiKtqYxpzP3NyPtJCtDairbMn8HVfBzdVD
 6Y5uPbdGQ5P2fQSP2zeOqOQM8QAoNAxuJ0iUN1Vy9s4EsOslla5QsicquERV0NWTv/4R Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2f4px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 15:16:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CFFvj6016221;
        Tue, 12 Apr 2022 15:15:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k33kcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 15:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J22U542t7z2y+JnFxtkU3krhZmIwUnsqv8g/ycYl90ZZMx7o5nuC25szvL9WHg56Bl343UaJBf/1kWkuSOFCjbpqCN19QjJBesESlEDUDhL5yRCnD8V2Fe45RQd2I/YtwDfYQWPG6ftMILP1PyA4U7s/idaclvMaOE1IlUKZQ1DZdI22WQ7Fpvy2WVgbNcrX0+Fh8/jfNDJnbeZlYlEvvLDz9Pqi5N+NPxBDuGtSaftyuqnv5Y4uuuH4N/xqFHeSluTR956jaJdFMRf6F9Pnk/gzGlkuc3iUGxO0rGZTW0IDKaycVsYIFvXYlQhaaVL/eXeIe6xb1VAzIQ6E+QDLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tHth4jUUen9FhPo02GcgvT0KBNbICsSUoUCt90hLnM=;
 b=T7xeqIan6rudq+S1YYteq/GZvMN6IrW6rtX2sxtSNLTG1F3i9K4JFQ9QJMZdKXxJWc1FDhl0GkSMfbu1ErPrpmZrB356mnvVZUalAV9QP0pI63I3KYYSZoqmjT+xXzPW/Wdwa1aXYNCwfSop5MYngD/ctoCf9gS1NK7I1SSELurbWQegDgntscCzBJDY5Dg4ZylKKmU1QF8l/TGxuim13HOBuuWo7QYwSu/7ElsfLVUfdbEkRcBK0yCQu1e3CSJOKi1wt4ificbO7ICDtWzpsvroU8E3t0NH7iJoLNt3pVpo14oPRPBTQif0RdLHZ4lmu6DlFE1KoKR9+92jwyKPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tHth4jUUen9FhPo02GcgvT0KBNbICsSUoUCt90hLnM=;
 b=xnulMogbLqVbnAFXQrlVXoNt21aqjN0Q/N9Sf+O6R/shyVdXQxveljRjcq2izP5oKLAHDjl9m06ozbTTskPAWQqkTQz+LBtXDPG/rrxyM6L3aW0p/hCfK1XHm7CbAY69UFuKMQlyprD5RQSo5ir98soa9faKACmkQ2jNBaZ/evI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5023.namprd10.prod.outlook.com
 (2603:10b6:5:38d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 15:15:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 15:15:54 +0000
Date:   Tue, 12 Apr 2022 18:15:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220412151529.GF3293@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <37499399.10thIPus4b@leap>
 <20220412050630.GY3293@kadam>
 <3484215.R56niFO833@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3484215.R56niFO833@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5010a2b8-26ee-4916-fcc5-08da1c975615
X-MS-TrafficTypeDiagnostic: DS7PR10MB5023:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB502344804A084E93E889FF148EED9@DS7PR10MB5023.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KAtfmaewuwzBg3kERAusuEYcSMzDFyGJ9CGfEVvP4egjh3Q3X2jCmuDLdZCB+60idOeenhUzU0yJ1g/mis5nAnfFBugYdovgIDtIkZiPyxtT0yGChm19QUlu2rYr6bL+CwchtRTqMirFlUKXDMP9fwUcDzJva4/wQ5hf9huFiam+X8nmkVhuskmDWRX3M54/Bq1skVgbG9Ljeqxm1dnVrkmzJTMjBOdKFOy0KvQA5s3aS9xkftUUMUetrtc2X4uprdMmiIFDB5RmDX0zEeXefETIb2YqIGm3sq1MXG9YEkjUkoXEBnUGhiIyI43NE3wPtqEd9zz1XkJZqRjeJC0pV8KEt5j3Ej78uTVT9lqbBDCkKGphptiI+A4O5223KPxhmGBdaOvZty78f47hhFm4JXHyOcQ2mcvpfQDYb+0MJga87qu9zb397dv0Yt7/onHKD9D+xjZOIibpuQ3GgGnFDMbA5akEc1L/+Xu7Cb3kgbFh/X4OWkYbf3D13xEbCRf/4B0EIGdrI4J4IcjqWBOGh19p4GcDhvrL6xDDNnleWQfQkIMr9ZF5YljYbtVjxqKV1Vh+EJEA5UlVhydC4zY3WfKeUHI9dIvKq1fV6PGQZynBQKZbgVfl37dfPCaS1HTAu+PB8wXZTLt9vFFkp1nF9/rrfTGZ8H7/Xtx7a+TckDPhf1VqqJMtgHK1PKdQq+cjFll7LKWBu/xTRfXBaQ+9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(4744005)(1076003)(186003)(66476007)(66556008)(508600001)(38350700002)(38100700002)(2906002)(86362001)(33716001)(33656002)(83380400001)(316002)(8936002)(66946007)(6486002)(8676002)(52116002)(6916009)(6506007)(9686003)(4326008)(6666004)(6512007)(44832011)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HqnPB9oXoGufF6tWlkvNtC8o44Q0+m7bUup+Ympp8f7Z9gB9tD38YNBhbXUl?=
 =?us-ascii?Q?TFE+ZebbmF7B7ZsJbo31o0V88cGskefltg5HeHOSKGZzAU72XmMIVLraFnTI?=
 =?us-ascii?Q?HQt2a+zQR7dlJ+auKzlcuZZ8gXHMMA1OQZE/lDW9U/mtjGiwcgMG274PQgZd?=
 =?us-ascii?Q?b56ZsNqKrZ9GtMjKkg+UtwnTVtIBY0Cv/luegmfl7upylSUG16JrRG9OCmDe?=
 =?us-ascii?Q?AgqHoALj+qujQ0655+NCRj4vkfz7YzihHj8u3YvDSJIwmaCMMG4+7E9RFqrC?=
 =?us-ascii?Q?ZVVJattANjwNdll7TzCNlFysDPpxtotVZtx3cdk4xkK5oht5it0ait11ggpq?=
 =?us-ascii?Q?7gY+3Ccx6jarUHBz8jnvERMqqBGkKSPW2PnHKNyw9lrGRhxD28uRfcXeazn9?=
 =?us-ascii?Q?NCySqoWtcsYgA4voJmwlBQ0excg/0kmaWzSEhcj4EUt+3ozEWQnWniprKgm2?=
 =?us-ascii?Q?iZEPRKWTbTQXN7XkOiGlQ5xPFLl1yESi7TYhzGjnLJ67k1HYkBQ4lusKRTeu?=
 =?us-ascii?Q?zraMHEd2fkZZmtU02f3aUhhanFJqTERLTlC+Tv7lmOCQsgugt6s2MoGtHp45?=
 =?us-ascii?Q?lSK087A/Ih89E2KstEu2nSxt/bv3pUqTO6CMmqIbBO+B6y7bAMml2PQGoUG4?=
 =?us-ascii?Q?O7sVc/j84Hlxn5gOqlHwzwVl/7nP2CYMQq5dGpKSNwdtyBns+qFWzvGA33RU?=
 =?us-ascii?Q?kAb093mSjOn85wcO6YRfQh8lLhm0P0oc5WPALrGAlIVmpPKQVCU2REZEhnGN?=
 =?us-ascii?Q?m4DislfgXpXs6a1TdBWCm2SCe3Cx/MtmTrq1r/7Vj4VSkvi4hmrHJlxfYCFI?=
 =?us-ascii?Q?lAYjX/ZN4hHM8CfXCzMQVk7fdApcWoufdF3aCUb9kZFkyA2HL3qvPzLMlhFb?=
 =?us-ascii?Q?Xd6yFQGFRQg2lO1Ie0yPvSCQjQGVjni/pYcPj5ZxKdhmFy6ECdg5Wklpar/G?=
 =?us-ascii?Q?7sRMOygOpExHW2ObJ1OGgSGRhrZZ+ZXXDYmX0JDAS/H/PsecaM8WJV9olWRl?=
 =?us-ascii?Q?7oU2ftsV3t6u0Pp+5hdUB7u/Veeb/1WO0kbBVK1I0/qiZeagq7jEkQ7ciYE9?=
 =?us-ascii?Q?E4j35NJ+uHgosInikBZBT5ijvZ6yXKPt9Z3gRbsHbyfP8xzDStWiXEe2LSwm?=
 =?us-ascii?Q?odYtmVK9UpzveGXUwF4XnyBoE40x3O4gOhIquPoYm7nQJNN+YpWofaC2PUV2?=
 =?us-ascii?Q?//qPAy5YwH0MEvqSmqWKujO+hrKIXdn1KNW0GZyamzwLdYIwsO3wWCcUFp9l?=
 =?us-ascii?Q?3EMH+0H5P+haYquTSMbPif2PBnmUf1jYCeJ2OGnyy/bptgUsxE4PzFLJLkS8?=
 =?us-ascii?Q?OaJPCdaWsZbME5aeVD0buf4Ynjg86r82r26LxCTcmhynDqeRQfeGpcWkAWpf?=
 =?us-ascii?Q?XBdyEtR0umi+vcg3BpoCzp2JlWMH8E6Mi0B++GsJE6oLYheTyROpfkrYQXhP?=
 =?us-ascii?Q?CC5uB+xBD1eBCTqLEDqEXBxgOiOr7kUFHUpu5MhZN6y3oJxozAI76YgIwu3g?=
 =?us-ascii?Q?R21NC+zvTQ2GJMD5HAPm5RmyM+oAOUljIcrmoEUZRA7DmoGjLKYyijbeIJnY?=
 =?us-ascii?Q?/SrJng2BKTfH34xOr4iil2nVBEbrduObc9oB1+nDWCNR7YpyH9nhve19mzuZ?=
 =?us-ascii?Q?rYyS2xwJrsmFz6CtyCGNcIZxKpHybZtLqQ8yUWjEViVuPH/Ff6l5ZtKtJlFu?=
 =?us-ascii?Q?frimSptiQ/do2MHRDGsaka6hWAAPHgo4rSq3lbKbXOnrwoe5JZg1MP/C010y?=
 =?us-ascii?Q?fQyflIEyiqSNIE33JTKEb2vVLpE3NYI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5010a2b8-26ee-4916-fcc5-08da1c975615
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 15:15:53.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRLY7PFEnMBIsWJR08SBY55yQytA0I71fFHjnkZHmUWaCZaXCxsrC9+09RhAt5QU4gLsn+CXfsbrM1en+5mYln6uiD/sTMWKAJiw+6LAstw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5023
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_05:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=844 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120074
X-Proofpoint-ORIG-GUID: bbILjrZET4pxMok8jq5kdo-0eoEgtxri
X-Proofpoint-GUID: bbILjrZET4pxMok8jq5kdo-0eoEgtxri
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:53:42AM +0200, Fabio M. De Francesco wrote:
> I didn't suggest a re-write of the commit messages.

Yes.  That's the problem.  If you want to complain about a commit
message then you *should* suggest how you would re-write it.  Otherwise
how are we supposed to read your mind?

> I just pointed out that those messages are formally inaccurate but
> that these kinds of small formal inaccuracies

I'm so puzzled but what you mean here.  There were no "small formal
inaccuracies".  The patch removed unnecessary wrappers exactly as
described.  Anyway, I haven't seen your proposed commit message so I
can't say.

regards,
dan carpenter

