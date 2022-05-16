Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABF527EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbiEPHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiEPHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:34:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542822315E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:34:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G446dU014196;
        Mon, 16 May 2022 07:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=WFPhRLr3iWkbpLRb4F1Ivuok2HSzWXNyRHGMCeLJ4zA=;
 b=EOC9Y3Wwfrzv7/MH5+2t25ngk9kQx5TME1B+RtMjsgUcj92ddSYzuWxQ9JRuVhDmbkNA
 iOqnnHrMLsb/ovgn917LYFKH8s6RLkSsqrDkI5fPL6d/77kzinlypTkugiMxqai3cVGg
 MI5nkU9d2m/NRID788sF7IjdgZ/fct3EKwXs7IHHrRj/wRACKgNABQ1I7ZlkHOBTVNuH
 MqkK1YlS+EADM1P4fOCAtd/9N0j46sv+D2J5v5mrLI4yROnX5QC3j02uSUhnVT7oFst5
 LNY6BZnPizq2Hqz6OlXQnY2AsmgwxUCLWN15P6QRyZpRIerTEfeqcLfwu84SqBIQ8A5L lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371th5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 07:33:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24G7Vfss038286;
        Mon, 16 May 2022 07:33:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cnmn2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 07:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeVyteeebiCF6swdAiFdIyW4nNeYcmKIwLbLEzzIYWxPkHNfVXrnPmuVwkCNvts5jhlGlLPVRR3aLGKJlvmtjjLLR5SN0nWE+RMi/c1A6Ki93wh7RpXqFBt6mBd9AQG72S9FM8x1hyfmNIU7DgAiFqbUjrG85K/HjbbnH2qH1i3X7SUoj+RhLOGkeMXCNVQFcxZwADrDuqAfTcnUpSyPz22JEyLZ4Gf3mInzys3TUbDfKm60IBDKTZUKu2/uHfpFDd3Qxhi1lZDcpLlMHKWS8Bu7666FuRaqB7Qae80pA4jcAuk20i9fUQmyBa5/Y8FVtNX5m2F02p2q04afGgSSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFPhRLr3iWkbpLRb4F1Ivuok2HSzWXNyRHGMCeLJ4zA=;
 b=EX8YPBnaxFdsorWBRT3+oJcDxuQCvNXSk03tFiayJj0e77XIp64nuf7UTIBuiC7M6rNhvNz7qnUZWoxYivZOB25crR8usYoPo1Oa3x7Y9PvMDVwDcmxsY1aPKrLWO2uF8cR5opiWtWQsJZC50PmO7P8a7Yx7PusY2Zguc5PpGRAYlFVAMjNcH442sSDuBGi/GL3x9mkjZj/Noj+/NdTr86nOvmPlTXxNO+f8+nekJDJZbRfH2EJv6h7tblZX6kQBtb0HeeYVvp9q4RE1apdm3eAnqwen4KwaKugtKA63rIozKXslZhZDBjWDqeeWWmAJOWnuhRyD4JZnUfS9P4I1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFPhRLr3iWkbpLRb4F1Ivuok2HSzWXNyRHGMCeLJ4zA=;
 b=G95DUdLJydbxPymcqI5ciN5UMxEYaH08z0yPSQHpQssX6rbUxJV6z6CWpnhHYi6RYCYciGQMDv1Oj8hCLZLxoMposhOLzWWoNs3kFRpBSHeXhd6f9Xf7/FiDjYynbA0YYf40DTDcos4oJ7u0Je2hyQwlrxoW2DpQMUNaQoXFiSE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3589.namprd10.prod.outlook.com
 (2603:10b6:a03:129::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Mon, 16 May
 2022 07:33:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:33:54 +0000
Date:   Mon, 16 May 2022 10:33:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?WWHFn2FyIEFyYWJhY8Sx?= <yasar11732@gmail.com>
Cc:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Don't use ioctl for per-client
 configuration
Message-ID: <20220516073329.GJ4009@kadam>
References: <20220515104711.94567-1-yasar11732@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220515104711.94567-1-yasar11732@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8264d4-4a39-4511-7955-08da370e6e06
X-MS-TrafficTypeDiagnostic: BYAPR10MB3589:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB358969BC4FDD93D866A61F458ECF9@BYAPR10MB3589.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMzpCcrwjaKMEFEDQiheIdCykDp8LbVLy8FJ5yzLjrubTS7qCpHdxoC4vh6i+XO+QL88O2B/7u5I3RGsIxDimEoa5xrsSLabkJ5eLr5w9M5GnG86W/Kxwu0xoy8h5xMfJdv6h4dLgPBlW+3L6y4s2zwHf/stg0IGkNp/OMQI3Q1n9eot2+W7rDF8zmphtJu/JoKmlJXPjutbBE/ljjeTWiR7Tnjsl/2ktVEKs1PCraarg07dkB4FvGMWo/EFP94men8lZOKearcljDG+d53rqBZYkEtOUtnNoB0JletOsATBQcMlaErtG3WrfOWBbyKwx7Y8Ueea7aeekLyAR4SnxSaw9tLG2Rn1ZDh5UWI8MyAGErfWVsKbCMkIsSckd9HrDnXnAQGJtiJslrgrc78UPCrhiCNSSTrF2wva5vzCFYW/SoxE6/CAyxUITTPOJnlOkb6MoJaP1wZI24rYl6RMhhmChMXzpl9JAlYtlVJkk19tjoiNXRYNBkwgoxSRiUsPBLUovlcIrZGRO3W0qPKGMHiuWyUobLhq3mUy7My/DoTcsoaABmAEKsq48QYQgRiiNQDAMlxerzNjnLfsm4W79ZB6dzGqt5E1AzgI1I7vFFJO2TyC0dh6wbLsgJPN6IDCZoCzXOQYrd6Ss91jCsy9lNnZHb6YLY14j1ZzYoxw6/qpzsv9tsnsyr5jF+uoh8LLCJN7lMCXKYvMzsCnldistw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(66556008)(66946007)(8676002)(66476007)(66574015)(33656002)(33716001)(2906002)(1076003)(9686003)(6486002)(26005)(6916009)(6512007)(6506007)(316002)(186003)(8936002)(83380400001)(52116002)(38100700002)(5660300002)(6666004)(86362001)(38350700002)(44832011)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUE0MEJzREhvSFd1SmlRak1pc052QUp6ZEF5elgzaVdqb1dTOWNkRjh4b3ph?=
 =?utf-8?B?REJJT01OK2pUUWNjNXluVzZ2SVNXamdFRC9RUW15YWVRYWh6czZEZ2FodHg5?=
 =?utf-8?B?VVM0NVJCbndSLzN1YTViMVZrblBxTDR1YzU0UVRRVGxrR0c0V0ZTQmxFU202?=
 =?utf-8?B?RW80VWJCN2lBeUhJaDhkSmxIVG14akRBcnNQZE9ZS1BKOC9DV1NYbDU5L1BE?=
 =?utf-8?B?cnUrQVgra3Z0c0tXM2c1SXBPY1pvVWxNS0tnbHJCbVRDUEp6Snc4cU9DNUdy?=
 =?utf-8?B?ZlZFMGNrR1lVZy82clBMUVRHaGVMcjdOSU45RmYwU04xQmd1Ykt6cXgrMGxE?=
 =?utf-8?B?M2UyTFNFNmllVzlmQzRLYUx5KzNKQ0dNZVBIY0dSMTdsNWp1UDJnR2l6NXM1?=
 =?utf-8?B?M3hsR3ZKaUFjZGZBZ24raFo0QTBYbU9lendGVytIZ21Cb1pZbG1MWXB1VXZS?=
 =?utf-8?B?S1pBcHlYMVV3OEowdHdvZnpLZTFTOXlFdEg0MWZsa3E2aGYyQmhBWFI5aHpx?=
 =?utf-8?B?UWFYcnZMR0xSUHh4cTZlZjJFcmFjdCtqWkFjZHdsbXlZam5hSk03UEhSOGNk?=
 =?utf-8?B?ay9JTndLUSt6YzV5SHMzR29MVTRXY2dVMUxGUlJ3TTlUY29DUXFkeGU0bC9T?=
 =?utf-8?B?TVFURFFqZWhpQUJmRUpiZHVlYm5TQkVwL0dhZW9ZOWRTRURmN3Z2Q2xvY1ZX?=
 =?utf-8?B?YXg2M3VDWk0rUHhCSjU1UFhqTWR1SmVrTitNRmJKMGVacW5VVGVqUHJFUWlM?=
 =?utf-8?B?L2hIRElBVzhJc0hZUUI4dzZhRjB5d2M2N01YNTgzdFBCS1BMLzgwSTBmL1kv?=
 =?utf-8?B?VFRyMVpINGZsNTVMNDNuRjF1MDBqQTNoanNkdUFvR0haaE1ua3JNUVdFd3pT?=
 =?utf-8?B?L2JzMTQ5SlIzeFYvUjZ6MXFKU2tqRzJ5R2dEVGVnMnJJdWpyMnpoZ0hpbkI4?=
 =?utf-8?B?TlhSMU1JZytyVVkySjJOZGZNbWhxRnF6ckFMR2NIcmkxNU9iUThhWWNtajFY?=
 =?utf-8?B?Q0dXbkZ6cjB0SWl6aDl1NEQ2WHc1ZStlZWM4R2JBa2gwTlRsdzZORDh6MUlJ?=
 =?utf-8?B?TkVVQUV5dGRaakwrd0VjN0RBMTJEUHJmRXpJakpMVEp4ZE90Z1pwWTZuL3VF?=
 =?utf-8?B?ZlY0eHZQZWhLcmJQTWkzL2w2c1FxeXBUdURSRmN6NWhNQ3g5OW9uL2hxbDZk?=
 =?utf-8?B?VFdkaHRFdVZBTlR4WU94bi9NL1JPQzd3bnc3eHhxR3NQU3pXcmJNTEVUOFZl?=
 =?utf-8?B?SmxucDFHTHpaSzJyMXFsUkRJZHkwZHR3c1ZsTVRTaXJBa0I4eGtvSnlkcmgx?=
 =?utf-8?B?SUJDTVc2THk0UWx6S21HTnJSMklZUndldzk0YzdFbTRpd1pyVUZNNCtSMFJP?=
 =?utf-8?B?N0YyVUhzK2xDRzJsUFFkVHVDSEMyamtSQTlyeUcwTFBNZDFyazNBOGg5SHM4?=
 =?utf-8?B?dk8xelZpSU5GWUpJcFlGZlNnclFBc003TzZLWGM5S0NSTUNtWWJXdlhzRWsz?=
 =?utf-8?B?YXNlemZoVVpZNmFzSlhSejkyVlZQSTZFNnFiMVVCM2RtWG5aemNGQVNvaGhi?=
 =?utf-8?B?cGsvdExBNEthMlRha0g0eW5CUFRST1MzNzlFZFpzWVI0QTFtY21NSGRibUFT?=
 =?utf-8?B?MkV5dEpxc2kwYWVwWmZIS1F6UFRPZnN6T081TVl4RVBZMUpJc2JTVWpQMS9i?=
 =?utf-8?B?K2FmRSsrQjd4YzBxSjBGaVJvTjFmU0lMWXp1TTI5U2RBRGlRRkJpOHpuenZP?=
 =?utf-8?B?b09HcUd4dm1pOFA4RTBBWkIzU1laaE9EZ1g0K3BGTllFcVh1RW1JczZTdFJL?=
 =?utf-8?B?czlLcCtQNFV4RWhJN0VOK0NRc2RJUDNrQ1VjSTJjYjcrVEN1VDdaVEpPQVI3?=
 =?utf-8?B?MnNta3BvMWJkbmZEZ3FlOWlsRURRdGU3Tk1LYXBFM2dKWGJmMERoZFFqOTVM?=
 =?utf-8?B?L0VJMkUyNW5rNXJnbzJQYjVnK2hRM256VU4yVGtKMldzcWZJaXd0eUN3VmQw?=
 =?utf-8?B?cFpwV3J3T2taQ0l3REVpY0xZM2hWaFZueGRXSHY1MGF0OHFKRm5paHlsQUNS?=
 =?utf-8?B?SnBsWExRNDlHUW9HRW4rWXZub2k4eHRsVDkrRlhJOWoyQTBQblZ0empQeGcz?=
 =?utf-8?B?bGt4UFhYbVFWU2dDNVd0S1FYQUJLMTdBY3JUZmF3OFAyQlpEbFdpRkNVL2o5?=
 =?utf-8?B?ci9FK2p4T1B4TmxaWXRNME02NGc5amp1OHFiYklSMXNkYkpOZGpGY1JFT2tv?=
 =?utf-8?B?MjNoUjJORDZ5eWRvNEdtakZJbUZrMThqOTdCYk5zRCt0Ti9CVWtOYUk5NkI3?=
 =?utf-8?B?T2M0Y0JiWDFZckt6SExab2JkR05wVWhNMzFvQ1ZjRGF4SFVkbVI2em56YXJh?=
 =?utf-8?Q?F6ZqfPjYH2a9osTQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8264d4-4a39-4511-7955-08da370e6e06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 07:33:54.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcBpwrYkTHdqV61LVuLGHaEPdq0fNTs2UbABrowEmDHQH7YClWv/rZcOExaFoxZC58I/cQ+fdsbZyVjdNluwi7MTJvwpVATqzlcdBTjU6ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3589
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_03:2022-05-13,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=720 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160041
X-Proofpoint-GUID: huFo7Kn1Pgrm0RdDLDVvmUH4nY5UCDkd
X-Proofpoint-ORIG-GUID: huFo7Kn1Pgrm0RdDLDVvmUH4nY5UCDkd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:47:11PM +0300, Yaşar Arabacı wrote:
> Currently this driver uses ioctl for reading/writing per-device and
> per-client configuration. Per-client configuration can be handled by
> usespace and sent to driver with each write() call. Doing so does not
> introduce extra overhead because we copy tx config to fifo for each
> transmit anyway. This way, we don't have to introduce new ioctl's.
> 
> This has not been tested as I don't have access to hardware.
> 
> Signed-off-by: Yaşar Arabacı <yasar11732@gmail.com>

This commit is confusing and does a number of unrelated things.  It's
not explained well what the motivation is for the patch.

If I remember this correctly, the current API is broken.  It used a
too small type or something?  People wanted fix it by making
incompatible changes which would have broken user space.  I had said
that the right thing would be to not using ioctls at all but instead use
sysfs.

So I kind of remember that there was a motivation to get rid of the
ioctl, but I don't remember what it was and it's not explained here.

I had imagined adding the sysfs configuration along side the ioctl to
start with and then deleting the ioctl when userspace was updated.  If
you're saying that we don't need any configuration at all then that's
great but that has to come from someone who has tested the code.

What is this part of the commit for?

> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -75,6 +75,8 @@ struct pi433_tx_cfg {
>  
>  	__u8			sync_pattern[8];
>  	__u8			address_byte;
> +	__u32			payload_size;
> +	__u8			payload[];
>  };

regards,
dan carpenter

