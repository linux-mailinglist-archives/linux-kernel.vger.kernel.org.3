Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085C46132E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbhK2LK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:10:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24748 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376894AbhK2LIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:08:24 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATA5BTQ009517;
        Mon, 29 Nov 2021 11:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lJ7hSii6KHM+cNcdpk6qNWbjYcchkBnvSFmrnnyiIQY=;
 b=p2vNBI1kbOwHqGAogP20AfNCofP+rKzrmkihfL89EJNYtoyXg2rOrx1x2GIscAIyd8dD
 8U7lugMFCpQDUDnIiQ8Y63STTqG2FZJyDFUEl5n9V6LBML4Tcq9tKy8I4GNBCKh/emfb
 LeB2a62JCTrlJl20pC3YNPKcnO0zkTz9FBsn0NB4+IdB81POE6jjZCJy6mndk+u0Hf89
 Nmy6NPEbU3HXD1tlN4VNFabYHb2IhSpjw266cYrcduJUrLtwZMT3XOF4RReePcYBBAeN
 I7by8xS1AZVoSOwFy2Q3Iw77OGEOteZtKIRpjvXEdGtSeBDUMpQbB5diNEObqiS8o5uy 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9gpgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:04:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATB20hc069661;
        Mon, 29 Nov 2021 11:04:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4m3eb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZQgFdYGXuk5RTed3p30TIB/V0sSevavztjILHFym3Pv/0FF+rHhzw42MCWQLHgeSEjikRAcKCW0IxOLPpnSqkFQAnlGb8HAiYBk2ToYxuieX63ibbBU54/NE5N4ySWMzhmO1oo6jJevuS4OJzovpObFqKKPUi/nIz1xCWujLLIvhVFn9FzllFth4seEDgawhuI4nzo1m2Mwt6Z2oDfJokW9no/u9C7lPdEu4KXozsQWirkWDWcd/gCeKTOOLbDluOu1Aqe3smNIQLxkkf3BR78VaoASssC/2q5Ps62ydQYP7S397hIdsz/06GR88HRgRXuPB7nvYLOnu6/g32UHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ7hSii6KHM+cNcdpk6qNWbjYcchkBnvSFmrnnyiIQY=;
 b=XTgKAYFqxiFw9yruPU31EF0Sn/xCLtxXw0Ijky77eRn22vqoJYhFQowzhB8uwqcoT8gse4sDV+DplVA28boRtpLnL4oTe4lyk6n6X26G/+B37Ze1VpHWwiqdgzrY7RPXffFXpnabW27AI9pqll0SZWTLCmgGgy34Kl2z0GX8cfrqk/wae7o+60BrDvFkWfkLL6BWQihvRBAR6UCfQXrHNbT9EXHW8cgj2cJronVIiUHakSQuKdG18F6qUzG3EbNKVG9dFVQ+yLEovNnJkpnjVkofVydXsvy+lXlZxzpvP7AceicmYz08eYXj+31d2V/1HEihMI00n6XP7qWDMv5mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ7hSii6KHM+cNcdpk6qNWbjYcchkBnvSFmrnnyiIQY=;
 b=Lau4zqmB0/63qVyEn2VrV8WIEGsRT6K1J5lPrHH4EB8hWANIeyLgoWrKd8l5qP6uVE87wKmcv5IjnsZTmAHOT7k/jyvEi+Bp45TsFBXbLdrvF1HNyarU73/2CVmOttsDdnkcI3HdPeT5E0iA2fqe42JjEeNCcgJT9wqyCsEm7S0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 11:04:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 11:04:48 +0000
Date:   Mon, 29 Nov 2021 14:04:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: use a delayed worker for led updates
Message-ID: <20211129110427.GQ6514@kadam>
References: <20211125162513.25039-1-martin@kaiser.cx>
 <20211126114135.18228-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126114135.18228-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 11:04:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d53aeb47-c08e-4048-d1ec-08d9b3280f2d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:
X-Microsoft-Antispam-PRVS: <MWHPR10MB16613B528701D410A21CBA548E669@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlcxZTmpGYreA7reeD3XCTcgNypr8Jp5wCx1LGq2dkdXbeqGP9RsTYsfeMuyZzodEJqgmvTjuGnrgOSuLzY8ye4WIe4+hJLf9NVgbvwArcvwinXwOx/oDWwdnFZyQ2NAS12B9Cmw/lQDFlJQlinAVXiyYf9+JGwVjtd+pTWsb/Hi/6U1ozvaiq4vEVNLggRxdNVbYOIv5+tmvY8JeJrIk7sYlrC1WhIMLrA+aF6CYtFLo9TCAyWa7VvhO8/+/t/4RHAszTmDF8ThNE44kUi+5PD6rkhQypXsBT/nh+EIP08RnOSRWaj2PaH3CmbVjWGtZSY2MrtfBguYZxCGxzGd9pjBVFK/KMY/+mdIUY+F9srhQWvsJuG8+eAxJamf7+3vsATJj4cUyX39hMa80/qevtlKb+Hj7aE+RKBdXm94ZL3q9arWTG+/LL0sUKAGvbTTh95+R8D3/ndmz6kyfDWAKzFydbjxofLEd6CHarFyPYu3ffheVLDWFI/hKaLbFooXNYGmCpUav+XUdSbdOFjS8lEmtR6WBFx3ndDX5ro3WXFGZyjzKD5If4m/l1fAjQzcNkp+1KWGlcW9kid79XCYJgf961EI3dZ1ka9nbiAhmT9tyfkIRVBg4uGxoc6uwF/JCvqdRgyBPl80yv5Hh/70DpRQn8bRpHjF4DVL8jgS9L0q3P9uwtSZqcIT9vQd4EXGLHvh586dPP7j42UWI4m3Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(956004)(8936002)(4744005)(6496006)(44832011)(26005)(86362001)(6666004)(316002)(54906003)(9686003)(55016003)(52116002)(66556008)(2906002)(8676002)(186003)(4326008)(5660300002)(6916009)(38100700002)(66946007)(508600001)(66476007)(38350700002)(33656002)(9576002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jFWORPFXkZ2JV/b+V2AkdiJ7CzHfYPV6NSqyuDM9Ryl0W0aq7B45U2ZRXxXv?=
 =?us-ascii?Q?1OCBKmG231ZG4kCQrD6f0OtZ4EVcU0Pj1//qtlEyj6GLYdIZKbcp7elfVNHP?=
 =?us-ascii?Q?GU5V471t7bawbGLS/xXr7LJdlYwz7WpOSoqxrSIPgZOofRVY+MpbHj5K59RU?=
 =?us-ascii?Q?b74YZU2aWwkII5d3PR6UPubSdIAr0DQIc1SiPles4XlTUtPyqKVTJet+Ukpz?=
 =?us-ascii?Q?JxiCoSGq0TuzymhkoKO9o0ySI+va/H9XTSLIyzPAmXvy0ouiqke3j/umlIqG?=
 =?us-ascii?Q?X5jxs+5nwifWyJz1sLgRoQd+Br1YZednBHotaGRuvTxeczcBVEeXBJ/eKUBV?=
 =?us-ascii?Q?YcByNcFj7wORMLLi93E/lTiPHx8Tn2nZipcTBSuAGl8MlqUBmhV0X+nD7rhn?=
 =?us-ascii?Q?EmZj8NEmGWJtpCQSmRE25rnqPpEVm4lpIuwkBzIIgVZfJH8QCzZrYFg2Rls9?=
 =?us-ascii?Q?x5EOmo0npycw0tlrftEySqJ5wBexvFHr0cMLAo2TrzD/nBobjHMs2ma1Ew+J?=
 =?us-ascii?Q?2FaPpCkUK0HppR6BCZL1crPBHJC5SeVli1T1XZ1GcDqeFHpH2/B7V9KhQedP?=
 =?us-ascii?Q?lLCqpVy0UOHeASE0Y9MzvFYKrzAUKOC3o/k2OTmGKHOhb9F0IYLtInmnei6o?=
 =?us-ascii?Q?TVICbbXUg1kQalCG5OfjN7XegOdVWRi2E0kyQzuavsOqnnu3khztK/YcAx3H?=
 =?us-ascii?Q?oQeHJgVJS8cDRciW58EmUuSwbC8W1Qg5v4EGyaodY3NQIoWpfkGZ0jNx+Iuf?=
 =?us-ascii?Q?qh/WxCA4UpcjvBN634lpylfd6mdwgdA7IDcIjMDRDcqFvKqE1+afCxAilbSq?=
 =?us-ascii?Q?8ZjLh5JAgY+QX+gy3Np4I/3Bhd8XR74Jb3hWjmAbq3zRbDppv+lAVre+peTY?=
 =?us-ascii?Q?QuQx9kXa4dc6haJ7WPn/nPZyJmZUmlhNCqgYWNNFykp6/gqj+G2iBHvxvqB5?=
 =?us-ascii?Q?4UcCJ6splj0cS1A1v9gEwcrqP+5r291xLT4xcJz+dc12NwsqkRXq1Fi+KrvT?=
 =?us-ascii?Q?p0o31L6lNaOA/ZcFmL5zol1rqFbAO/B5DTG/orItYx6IploW/653+62qNw4T?=
 =?us-ascii?Q?A+p2pMKFasWdbeffP5wYw7nJdFhtl42OrbJkk6tvWlcvhCkyApHioPDYMFt0?=
 =?us-ascii?Q?opVLPHWPxZSGhfJd4WoAC0DCaQD2hnGj5MhU8KYiPuPZh9G50WsEqtPw+2SN?=
 =?us-ascii?Q?n5jeS+z724qK1KGAP5WG60p3DZvoP1a5716VCAC+MWrksBUVSsp0IUdfllYL?=
 =?us-ascii?Q?pvxRebrbzmyBemyb0BNSap5gdI68DMycbRVvYLNcuXxHMNmkPiTSggY+6Ama?=
 =?us-ascii?Q?vzMnkjUWyDjcg/4kBe0kiDTs/wJAUxSrblSJb0Kw/qny6myeGrxpVf0FmTwR?=
 =?us-ascii?Q?kWiyLSnPvz11Jm/Lxx1SX0ezo147vwaLxiIzd4DLETaBH1fc4Mo2Bml/E3Et?=
 =?us-ascii?Q?Z7hX1TfLD9OrrljMtIArTJ+JgSJXJfKOFq4EpSUfC/IY6loYQdEEu3xi+t7B?=
 =?us-ascii?Q?AXchcgWpjKM4pKolSUhOn1qUq/Mj9yNehe+Ow6LHYnr1plOkhl1Al16/t7Yv?=
 =?us-ascii?Q?EFvZ+sWEJrOzUyFdz5REkfqAUrRqJ7XQFLZEkhP061eDeIPPvZql+lSNFv5p?=
 =?us-ascii?Q?TdPG343Yn+P2wnXErrHwA99W1kVL2nmnJ3KNoGHamHoH55CEDHLRK8JkoCq1?=
 =?us-ascii?Q?CcNZdg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53aeb47-c08e-4048-d1ec-08d9b3280f2d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 11:04:48.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXXwxe5lGuprQwPW14NRIeqZvLNsfGlOwsuwvUj4OV5iTUX7l2/cg/7W8DMpMyvti8FDVvw2vEGCEDk8HY2CxU1+S2q9jzJO2nknH0sscUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=853
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290055
X-Proofpoint-GUID: r0-398Czq6aoZO0tDB48mDbrmbiBSG-t
X-Proofpoint-ORIG-GUID: r0-398Czq6aoZO0tDB48mDbrmbiBSG-t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was confusing becuase it should have been [PATCH 4/4 v2].  These
days I think the prefered way is to just resend the whole series as a
new thread.

Greg doesn't use patchwork, but these rules especially apply for
subsystems which use patchwork.  People say that patchwork gets confused
when people use the --in-reply-to option and I guess it's hard to
apply individual patches in patchwork?  Anyway, just always start a new
thread and resend everything.

Send a reply to the original thread to say "Don't apply this one, it has
sleeping in atomic bugs", otherwise it might get applied by mistake.

regards,
dan carpenter

