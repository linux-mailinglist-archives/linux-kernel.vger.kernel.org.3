Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D8508EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356387AbiDTRm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348613AbiDTRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:42:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D61582F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:40:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KFU3eo012431;
        Wed, 20 Apr 2022 17:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cCo9zEBC0vSdDto1WTVmAvw4VbFMQyHDw2tur53O6KU=;
 b=y6b22KpY4GB/t0LpRIJeO87rpzfFUyQ9CVHBjdyDcuQ1QTe2S0ltvNPINpj7aB35uZ7A
 TAYe27EjpCEWjHvEBhfk2ZJoOi9CilpG4LwHvOy9+OeY+AMmsBVLGHK7DqG7SH54whBC
 oSs8GP/jsapJAr5zZJBQaOz6sikdqgJbHG5946NqFT2pHpRAM+s8ENqVtsDDJcnbUdiS
 VT2MqG5eiwN8n0RMLARhO/7JyWvOhyNxR5AoKhhbcel26SVqUTPDPBew2O2YpMR5TqSY
 HU0xlgecg0a0G8epvb0hHbmGqH5ZXJV4soUYCd3WXcD/h+TPmur46WvNENY8UnhluiEA Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbva06m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:39:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KHafup023383;
        Wed, 20 Apr 2022 17:39:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87yenu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7POG97TlaoRp+Hpli2byelTfY+iIy+GGGPTjHk65JoezRxTC2ySMHd2xW03mTBhJqLIOt8wwL0MwyN8mleMPn8+sbdnklfpIWSY2ZiztJj9lSpjXGi+UhEHHQhCkclpKYvUEAaN5Dh2Snl2ME6kDC89qa8D4ecRBI2watm6qcRbbpGi0Ifcz8OoEqapzFzC0BSldyHeynwkSbIBBHlgSnqE149AU/BEOF0ldW8ZuNUnCJJrSs5UB8ku6E/B75v7worahSSclCrjVj5DkPd5kk+VYyTlh2chF0Spn6C8/ymOs/GPbsqUy177eQnY2z9N5P/w2Pb8i9xmj0dGzLA53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCo9zEBC0vSdDto1WTVmAvw4VbFMQyHDw2tur53O6KU=;
 b=DVMJC9sw0qr5zZAaPG3qQhBW6XfpCAa9tXMSoaikajmXiAKFtbaEuiU2slCyNDLbmFDXXYN6wKGMn2mbMrZo2wXVOVQApJsZYXThy+xGc6UkhOa7CU99wtMqy81H/bX+yUw8zKKi/g0tt3aHeUo3iTdrHXuBpPeE9AWoMiyjtzbGvhPT/M2spW5xb5SVNH1QXQAm8LsdzhDNbeRm6uN0LUnDcUZgxvKSPI48I0LFeZzBDMp73Q9WF93bYU5iPftrV/cpwIkzVW/Af9KdgmNsx0d6tSiaWxkjxwTWqaQn0AtodYemJBZ2fbmWf8jNOKd5B4qxb6AWZVeLw67eNHmPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCo9zEBC0vSdDto1WTVmAvw4VbFMQyHDw2tur53O6KU=;
 b=NyU2HyZQSxZ3qvriy8qExrx0RZt1Pt4UmtOPVFX236sZK8Y4bPHuykV0xLlvHY+/oQMzCw7EZsm4l5GOWWh8YziVlmaLk7AR5ul+q1R0YqOoYl/S34kmjqcIKCITM/ZNz4CjzrUzd7KzW2z8pAs/v3OGl0XxBZ/CbdhackcOn4o=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2196.namprd10.prod.outlook.com
 (2603:10b6:405:32::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 17:39:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:39:47 +0000
Date:   Wed, 20 Apr 2022 20:39:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220420173926.GE2969@kadam>
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
 <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
 <20220420115534.GF2951@kadam>
 <20220420144834.GA1313590@jaehee-ThinkPad-X1-Extreme>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420144834.GA1313590@jaehee-ThinkPad-X1-Extreme>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54993d95-44dd-4871-e407-08da22f4c34b
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2196:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2196D7332A78A1F91168FD418EF59@BN6PR1001MB2196.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVj20reoXIl8TMSD5Gu9PS75AKM65REcSUgH9lE1Xmu6l6uumI/o6uAcNPdq/XOBXBCzHSZaaNWo+OwOekcwnZDoEVyMmSWcuRTg4CFCJO0Keuyjb5a1KBExk+dehmVcvvmaHI0yWWYYd8fp7jJrrzGU3ZMFe1rt/zWhGrdtO5XL3Tz9b8FBzcymakXXoj631Un/jVtSeuZG74OFBh+MZibiKKNONM4s1o9atz2kj09cASR4ikC5Fax1FzLdLGYKLV8DBDmoZU0H/u87eZp3XkY2kDOB9EUa5o3ebLfj3qI1FazHarnV6Z2FsHkASIKVsliuwiifxphsakq4+8i9bXeCWaeE18lyWwA2pp81voBUT89ARabqsUGpmnp6fv2g+yiGhN4Kszw/pSWk8hExr/MFbD4LYwOC6wCoIIdhg2HKS9vicZuqdMYVoRTFtwETvjMbUCqcHfF8BztFmBheTOtD4zY8KsY1uYsgROj7eWwDiiqtJOu7Vr1Fjr6gerfL/k9TlvaM5KtPOvfuegsPf/43K6Yng/ONYPKBEifXrVWGSAPFTG9nSGlhP2uhZO7PJYS///WhqW5rEOGJU+1sgZVrH7Hd0PlCP92H1m7f1S3hUfJyrbggc+x46HYLxEF/HGJhFaYfkNN6G1fYZJ1mza209hOUBoolflL5uPj20wyk982XKmkmEILvEASwlhU1reBHJAUD4DanhGydR8QJNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(8936002)(4326008)(186003)(1076003)(6512007)(44832011)(8676002)(83380400001)(38350700002)(5660300002)(9686003)(6666004)(52116002)(6506007)(38100700002)(6486002)(86362001)(66946007)(66556008)(316002)(6916009)(66476007)(33656002)(2906002)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBVyqWiGolo7yl+sEBWUJzCJ20Va+VOimF/QBqSkpcHgk4c5uJYo3gmqfLPh?=
 =?us-ascii?Q?X7cBDlr6SzqVqX+aozbSOfFktgA16G6J3jO54yxXgf/Ww/YYnYvZ+AQ+TlJE?=
 =?us-ascii?Q?jQ48Ga3sMIdduzYGW+kVnMN5/LN1cFeWH0DGBdWy7a4JOQlsOPchGd0tkZ9m?=
 =?us-ascii?Q?OlduXCGvPaZrZbmQZmlZ6veXep7hHyQI5VY0JnYn3QOBdGmvmIbs7LqBC6VO?=
 =?us-ascii?Q?Jlh25XUZTtGOmeO89sFmBI7t5sqTxyJBk1rMJmJ7snrq4o5SCdQ8YoRHgOiA?=
 =?us-ascii?Q?A/qY+EEpyWbHNZZC0vMSjGqlEZsMX/1qhabwW6eVE7VDPLVsOnL2f9PC6/Uo?=
 =?us-ascii?Q?4JiIbHNWzoz9nBoa7mbPjIbozh5uOUCFaQabHWqnrINd8EDx0C6eYBdDCvnF?=
 =?us-ascii?Q?UKHyEsOw17M/C+McJRO7fsDfeqvOkD9mFFiIFQ9bO9AvdFeXpBis9vwigzkS?=
 =?us-ascii?Q?O8oJ36hFZjsfa0GqPEIqelbmmKqOWi8LbtTneulZVoZpfkcrrJH+UnJyUIuZ?=
 =?us-ascii?Q?yR8MgJ+HnSenvj4BGZKCbAeG9Tm5CNvNtUGxvyWMjhg3vmzTLoklJziSZD2A?=
 =?us-ascii?Q?vjLNADB5P2f6TKLxqubtmTtv72vLnK5e/WRWBNbbjcMQ+b1AK2035biCM/JV?=
 =?us-ascii?Q?G2qVLABb1KwTJChuknU8UZjSCbHEseyRy2Gv6QmnQRbVUKinugX8dmLkn9GL?=
 =?us-ascii?Q?cRFwKCfRxFhK+jRIKCkstznk735YSlf+wnhUaVgchVvr1U30Wdfq54MHyf5S?=
 =?us-ascii?Q?c0TxeTJie4zz7FlF9sa/8IljgtiVyZBmaXkgyJCIGN/56eLHwSeJolrnKcXw?=
 =?us-ascii?Q?WLW+MiZkHxGdNDmQuje0qnFwlgTzP9Yv3kBAJrlLFjJb/i5AddL5bpI7U4ql?=
 =?us-ascii?Q?fZCflPE4UnRJ5gxx493C8A+bsMAfETkxSlPVqKIRrSKUioejFWBjIy/oCkyq?=
 =?us-ascii?Q?C/gzMW4CmSCUbNjjHIfEydd4ad+QXEGudLKf/aQYOY4n0SCO9leDt7Db9U1g?=
 =?us-ascii?Q?pzcYsRyY+RWTnKsDthPC3MForqUs+mLTfqDIE50gbU5F3xMU7B88tt8nha6j?=
 =?us-ascii?Q?/qn0x3aCemI/zzPXeUlH3DoSg8lW00+iOidIJnD2R7PJEAmLxcP66RFkVSwO?=
 =?us-ascii?Q?ppnmSCDQ0VyDNv38ANVq8QjFsGfilw/Z5+VObamfULOH3QZB/8EHZsPMde+r?=
 =?us-ascii?Q?q9NU9+cxomAJxJkuskGzKRwXZGYAvZabIQHXxZkNe4f7wNjqEeiu0J58SFWj?=
 =?us-ascii?Q?bv5EvBDJvFLD/FnqN2MeWg+fEXBSrw1jGymuxAGLwKI2xyhoBXpW1hExpx1c?=
 =?us-ascii?Q?BjIDouy4+Tg7sWVAzCGiyZVxgV+kbp5GD0F23C1hi9oLKssiHIbawMewKbsv?=
 =?us-ascii?Q?WJ+lcb5yPONDWVJQfFwk9yggLrav+E6QgDa0jnESZhuJomLtoKBKiCGJJf4J?=
 =?us-ascii?Q?HA3iJnvuiBGsZ45FzLlXuDJM8VLXV2NpDCjxD/iZfqteAD1mT2pYxulyQfnZ?=
 =?us-ascii?Q?n6eRucg79TdeChRgkfn7VLuPpUoeLBv3NCcHTwY2MreSC7ziw/xvN62VgTt+?=
 =?us-ascii?Q?oyCKWHuVwMYhwaO/TFs7EJDnvSAbelWyOjrGr8lGu5vUjBzatKGDpo9EGCdE?=
 =?us-ascii?Q?UFqU80d8u2kRUCVYU/yUlPBAbEQM3qQF+CZOvbP+i31k9DfbSaQ+65/BmjHB?=
 =?us-ascii?Q?zNipEUqya32tJAnOmZRKg4VVUA9tnf6KR6ijOHwnB2TOdZgHWnc+vxpJDkJJ?=
 =?us-ascii?Q?N2/4O660c9g4Guw1x5j0MsXyCmmcL3o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54993d95-44dd-4871-e407-08da22f4c34b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 17:39:47.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Odh6B8lznjBjvtWwGvQDZDJJHWtwFToBlppCQstRrCRDaLh2fj9k2mjV81NJi4d5wzGDjCtYWVHcDhAbDc3LNprxdWLcRYptlWbQx4L9qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2196
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=969 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200104
X-Proofpoint-GUID: ySf6j5fFn0DNupm9qPm3_9fyINimMFul
X-Proofpoint-ORIG-GUID: ySf6j5fFn0DNupm9qPm3_9fyINimMFul
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:48:34AM -0400, Jaehee Park wrote:
> On Wed, Apr 20, 2022 at 02:55:34PM +0300, Dan Carpenter wrote:
> > As a kernel community, I don't think we are pro-active enough about
> > preventing bugs.  One of my co-workers and I have started a bi weekly
> > phone call to look at CVEs from the previous week and discuss how they
> > could have been prevented or detected earlier.  Of course, my solutions
> > are always centered around static analysis because that's my deal but
> > some bugs are caused by process issues, or could be detected with better
> > testing.
> > 
> > In this case there were two bugs proposed bugs.
> > 
> > 1) The memory leak that Fabio noticed.  Smatch is bad at detecting
> >    memory leaks.  It's a hard problem, because in this case it's
> >    across function boundaries.
> > 
> > Fabio caught the leak.  I don't know if I would have.
> > 
> > 2) The NULL dereference.
> > 
> >    The "&pnetwork->list" expression is not a dereference so this is also
> >    a cross function thing.  I thought I used to have an unpublished check
> >    for bogus addresses like that where pnetwork is NULL.
> > 
> >    Another is idea is that when you have pnetwork++ and it's a NULL
> >    pointer then print an error message.  Or even potentially NULL.
> >    There are various heuristics to use which mean that "A reasonable
> >    person would think this could be NULL".
> > 
> >    Or another idea would be that we could test patches.  Right now we
> >    don't really have a way to test these.  But, of course, we wish we
> >    did.
> > 
> > It's not super likely that we would have committed the NULL deref
> > patch.  I would have caught that one if you didn't and Fabio likely
> > would have as well.  But I like to remove the human error whenever I
> > can.
> > 
> > regards,
> > dan carpenter
> 
> I'm sorry about the NULL dereference. I wasn't sure about pnetwork
> and I should've asked. I wanted to ask why pbuf should be removed
> when it was being used for pnetwork but ended up not asking and
> sent a faulty patch. Sorry again and thank you for explaining the
> errors. I will be more careful about memory leaks and dereferencing
> errors. Are there checks that I can run to detect these?

I was going to suggest that you could write a check yourself, but then
when I looked at it it became quite complicated.  :P

How about I write the check and send you the output tomorrow?

regards,
dan carpenter
