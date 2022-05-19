Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4F52E007
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbiESWfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbiESWfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:35:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA7BDA17
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:35:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJxH3S016065;
        Thu, 19 May 2022 22:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jwF+2pFsIvKDsGIWmLMT9hSFXWbk6dm2iTXHhtB8Tj8=;
 b=b2lZ6c1m2oHgILWKkalFRoGecxRUf+1jwz4pK4wWwZLx9v6/xV3EAftQ+b6NcX1hGjf4
 WBQmoDhEhw1L13GAvOoyf8vZQzIknb1+tbiiJ/w5Dcw7tMulJd4c+dxXaRDTJcqO0ZCP
 H5wfTrCIcWJXVbEwKvC/fj8ac3NZTIuF3UklglYsF1dnnNSHd9GwYRf3L5BPb6TLOjt2
 tcb+o12lwPdjqKoTNwdrczfOAjo+919hLUGnJ6PSdMNphfJRr1N6sCF1AftKix7oxxiT
 PXVYc6WwxXtYWJ9VJT/Q0DO6/OYdxztlk/60KoJr1l9FsRwy9qNJXyhvMctH8hYk+iwz kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytwnh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:34:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JMQ9xb040597;
        Thu, 19 May 2022 22:34:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5vnv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx5qBZ3sDadV5flZqTQ/6Zld4nF2FyZqWDWc+e6JLo1In02Ad4R5LP2xJLZUjT9yefFNdjt3p9FkMpnvOF9lEsGG86q88xLr3R4UBW+NbESilNZZTxFFnB6HMHuVmwgOMKr7mqFwMnqRKm87UWhgZeGPCTm6FY3FGlEMw+Le/oIhfI8qmoI3kztCs9Jzp/llsUfZ4/1iVeRMh1V3NJG+jQATQj0bKd7BU+uuEZQ1jSQ8QiB2fGDqhx4Fy+6VmzWiSsXjHcxDbpzZLJrqiFIaXKbqqlwS0JsWCOof7BwVO/nX+K0IRlK6eRiWD2X9enwNVZC8IHzqVs48NmnPbXMEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwF+2pFsIvKDsGIWmLMT9hSFXWbk6dm2iTXHhtB8Tj8=;
 b=jKPNz8f4+wcguqsAHSC4A52Pu2UyKt4LK6HIFnmvXrvyGsnFmRysBekw8U+XRkowfHZHNOeXxLXeOX2HmF8Xb365Hup5eHDrAZ38YEjon1prVNcsTB2Ycy4BYIUS0hWcIz6s5e9gZIMMvsSuOVrze1yVeAQbC0YQbr1YRSm9pV3G5sTcc3j/I7vHm4KNM+aS/FVzhWOUsbAOJECOToDG+5aGyzMbaE8jS87fqKeY0pkMC/8BbYwBrNxYwN1oqf4Bza7Mym9uokvlscCkZBIDj1eAizAbGgDpfndxH7zPfxGYc3i+VKc7LBNIeZKJdQu4Xac0KLAccwlqB037mf0RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwF+2pFsIvKDsGIWmLMT9hSFXWbk6dm2iTXHhtB8Tj8=;
 b=ucjsWVIjc/CvnWiRxyhs1HvvXR4b3aYNAx52xRvpJ0JbVa4nLDrnUNZ2vBrdWu5wtMu5psznqw5qImtPau0Y3kWaDtd4+HloSNovfcMuhHusz1D3LjlTV1O6oDtVMEFrsmzXmP6f+nZ3SINEBFPhNq1CsOXIsjDMHdYWC5zHDtQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2296.namprd10.prod.outlook.com (2603:10b6:910:49::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 22:34:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 22:34:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Thread-Topic: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Thread-Index: AQHYaPp0ya25IVmpGEOQVFiK/GoNEq0mm3EAgAASAwCAABOuAIAADigA
Date:   Thu, 19 May 2022 22:34:44 +0000
Message-ID: <20220519223438.qx35hbpfnnfnpouw@revolver>
References: <20220516075619.1277152-1-surenb@google.com>
 <20220519122904.5aef389360ee2cba42d7b4ca@linux-foundation.org>
 <20220519203332.qsxuzxt2mufcbv3e@revolver>
 <CAJuCfpF4XjBmNGBe57aP0MYQguR4qHqeP=jeG87RcrAV4ODZYg@mail.gmail.com>
In-Reply-To: <CAJuCfpF4XjBmNGBe57aP0MYQguR4qHqeP=jeG87RcrAV4ODZYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50132914-b709-4dcf-8581-08da39e7c602
x-ms-traffictypediagnostic: CY4PR1001MB2296:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2296AD15C5D03A1218FCA6FCFDD09@CY4PR1001MB2296.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Aoeb6OW7uO7/5Y8K2x6DJOJN/AA30ZXWaeONFGnAiqkX1AMS2YVax7WXnYcYlwLIEFO2MnQt3jTf43/diFKgXUmlKSDy7jO1wzSU5RD9QOxtQySlwTRCdki5bGE7es3HPbGnU1774fxLyfUEO6VpO2mklrkhYekGF5HPgk392K1WJi7SW6sweKRtx+5Rcv9MNPQXz3rVC/MN7Cy1faJVzRDqP+/esXznNSdfT96lu0kW30+Sc0b0hKEwc9K3SmVMa7H6C7lA/s3cv7sAdP7gxbRYKoLpFrB7TeWa0UjxDce4sm6hcZQQzjlnkSHTvMy5ZlboqK3wORAmbhcvWun7Z4Bw9CFyHdzahpz57dotxrOVLJ81EO84tVVFUWf3+GF3aDNpKlCYBPKceIpVUjc5JW1M//BsfSmp2RaNhkEQulPj0Xwz+HuhaZiAxqQSCh7432qUu3JUbRGHasRS1+Ddf0HOuE4ZMyl4iERiUu8A/kT071e3L+/yEp1SKxAumrLObEnk69n47iFgjTghBXbrXChQsXejsKrznckLazYHixY4B2kCXrOj2Zdyg5gl3Sgkuzxjc9NZqBj/xdVQ56hSKfTRlN6r3Wx+7OoUoPR89Zgn5hUywLgdgUTMrS+bVeNCDZpqjJ3+UIQHxceyweEqJAKfyNKrYdrnfrPrrKmPmVhTSZUpuArrCV/bngRrgfY7EGiqw8xo5XK9F9lHKmmNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(91956017)(66446008)(64756008)(6512007)(2906002)(38070700005)(66476007)(26005)(71200400001)(38100700002)(122000001)(33716001)(66556008)(66946007)(76116006)(8676002)(86362001)(4326008)(53546011)(9686003)(7416002)(316002)(8936002)(83380400001)(44832011)(186003)(1076003)(508600001)(6506007)(6486002)(6916009)(5660300002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgR5aQCe4XH+yjrUu5/P0ZtQBHgYp401lbBxVL5uY3G+ZmAGFnc/+OtoO/Z1?=
 =?us-ascii?Q?OIuLj8U3ye07QRFxjYuHfo9jMQBY1qws5EcII3V7e1Uxd+DAPfnOoEZvHc7Y?=
 =?us-ascii?Q?MnnFWGQS/YSc/c495jIhKb0bERENkuSBY/EIxblpJ4idIIFQY1o2HwC7SVxr?=
 =?us-ascii?Q?bLR17Ed/jJ1VXteaFDZ2Xoayrgj6YB4lcdmK8Ukc87xCvj9/iNdmbzZO2JHB?=
 =?us-ascii?Q?lv5u0JKshpipkd1zVFMmwVAuNOsVbg/YBnuIW0SjKfxGsYJFSiz4XJ1lf/OK?=
 =?us-ascii?Q?meE6rrpkH3wZ+R2Pm32vM+puIyLop32uCqgEbEHS2p4M6c9awVS/Gggg0NUz?=
 =?us-ascii?Q?wC0DXuhhK/aOJQuR02GTaY6drVStrpoKjKWymC78hNWoXgfuqhT50tlxyhDQ?=
 =?us-ascii?Q?bciM4iRgeakLMyFEr5scPs1YfyzWO647c5i9YlFo4DsrqTWrudC19AAXZ/XZ?=
 =?us-ascii?Q?JZ3WzIuQNbVoRttlTVzNhVS9+ttHDM1EkouHx4D5EnnagWF1OEE48y9s8FjP?=
 =?us-ascii?Q?9LlADmSyPoYgcuYMcieiCnZGBh/O/80IQAo1qXTLd63FmxZ9CC3YS1y96YIO?=
 =?us-ascii?Q?kjN3fKRFh/IQArtl3oW3ga6jA+ACJmwjPCrXDj52AILURlcaXCW0Mu9x/05c?=
 =?us-ascii?Q?WELUBsQ0goQIEvy8hpV5a9iz13bwxlRhMugC809DmOSCjXLyYNAvlGptzmYI?=
 =?us-ascii?Q?UwJY7lsKKr4gWtfClZUb5GZCRtHHzBbK+MZC0MztaC/OZRcj+2cgBWIU7h4I?=
 =?us-ascii?Q?grcsn/HNttUZ/CqWJwnPIwcoTtPKaL3dZ/cs05OQeYyR0PH6N+sl2As0a77J?=
 =?us-ascii?Q?2pRuWsh3NbVEBej6L9/xDOZGgRTaoYkmLbLezbHVL52oLQDeb73GSECaZjIP?=
 =?us-ascii?Q?AFcfZn/UAKlHZ0eKV36GxpeC+aNUgoRHaPP3laBe7TiTYN2sZqLlxpLXfz4/?=
 =?us-ascii?Q?42Va7x1wEdNf+XvBt3+UNSBj2iutq0TUSgTTaRL/bLu8sn1o2jjLpms5qRLh?=
 =?us-ascii?Q?ow8XsDmWXR1cKPLRGEP3zrkSLcPlMjjY0lt8iUVvSDkdnuNxUjt9c1iYAWXB?=
 =?us-ascii?Q?2b9VvQpXOC2IB+XAYITacw/ZaLJXLydItTP/3nRF80IIAEbavKX7+ft38ZBw?=
 =?us-ascii?Q?Hg5m4FJGMBKY2yQPQHjK16MjctFlfDwM3zbofbki/82fO2vbUHt8dpvm+tPo?=
 =?us-ascii?Q?iNAgh7c2Umynf9y61L7Gq6XJ8IKu7DlB/CWYFGlDDmlp10tXzxnzEOeMIMIT?=
 =?us-ascii?Q?gyLpVtkwNAaiblDHcd626Ej0PuBkC2MmxsqRTeA5Vlvcpoydlvav8/Ik84r8?=
 =?us-ascii?Q?aefkaI7g9u09BsuPOPtL6tidFzxyZ8V9gA6xqNbYoxB1nQggnhUcZGbgX7Bt?=
 =?us-ascii?Q?9SMn/dLHkM4WGOsv8Gxb3tw5WWvXopyOBMU0IGDj4JikUA8i/vYzs9ZGWYGi?=
 =?us-ascii?Q?lBGvpRctONa4v0gFpk2Xp3AHirdUWzBMBh/NR9nIdLndwUDp/OxklE+Lhohv?=
 =?us-ascii?Q?ZX2m4mtGNzzkMT3K0LWR7hkPuFdlWQoRk0PgbZanwpfd4/0eLmWMRnpsszGb?=
 =?us-ascii?Q?Xu1C5fUyo21rfaqyXZ/KsayoxpEbKAzg2FrWKgGN3Nbt2GFyV7PHZEFG/mKJ?=
 =?us-ascii?Q?w0uM8To7x/6rcqAvpcXH0XIeSt5xD7NdbgGf/dEr4kklj5hlewRdkceVPEWc?=
 =?us-ascii?Q?yM0NJkCr790JrA8u7rdcliuk3v9nh0hhdVZvhAu5TWC5xUeJVPeBVMRQM16e?=
 =?us-ascii?Q?obfon94qIKT40vEtW4q06IIpXWpxYzY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7A8B5AA02DD5145986294EE0257DF21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50132914-b709-4dcf-8581-08da39e7c602
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 22:34:44.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +g7Wt9mbyDkUYpbyIgKOz+U6Ou/2I43JxloVNLfbxFWEBxqEL0nUPKGOlEzG263DuZwD75Df6mdcq69R6EBNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2296
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190121
X-Proofpoint-GUID: _oFp3Ptyu_nyELBgTVBZn5P6MNmlkQhF
X-Proofpoint-ORIG-GUID: _oFp3Ptyu_nyELBgTVBZn5P6MNmlkQhF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220519 17:44]:
> On Thu, May 19, 2022 at 1:33 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Andrew Morton <akpm@linux-foundation.org> [220519 15:29]:
> > > On Mon, 16 May 2022 00:56:18 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > The primary reason to invoke the oom reaper from the exit_mmap path=
 used
> > > > to be a prevention of an excessive oom killing if the oom victim ex=
it
> > > > races with the oom reaper (see [1] for more details). The invocatio=
n has
> > > > moved around since then because of the interaction with the munlock
> > > > logic but the underlying reason has remained the same (see [2]).
> > > >
> > > > Munlock code is no longer a problem since [3] and there shouldn't b=
e
> > > > any blocking operation before the memory is unmapped by exit_mmap s=
o
> > > > the oom reaper invocation can be dropped. The unmapping part can be=
 done
> > > > with the non-exclusive mmap_sem and the exclusive one is only requi=
red
> > > > when page tables are freed.
> > > >
> > > > Remove the oom_reaper from exit_mmap which will make the code easie=
r to
> > > > read. This is really unlikely to make any observable difference alt=
hough
> > > > some microbenchmarks could benefit from one less branch that needs =
to be
> > > > evaluated even though it almost never is true.
> > > >
> > >
> > > Liam, this mucks "mm: start tracking VMAs with maple tree" somewhat.
> > >
> > > > --- a/include/linux/oom.h
> > > > +++ b/include/linux/oom.h
> > > > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_s=
pace(struct mm_struct *mm)
> > > >     return 0;
> > > >  }
> > > >
> > > > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > > > -
> > > >  long oom_badness(struct task_struct *p,
> > > >             unsigned long totalpages);
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 313b57d55a63..ded42150e706 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
> > > >     /* mm's last user has gone, and its about to be pulled down */
> > > >     mmu_notifier_release(mm);
> > > >
> > > > -   if (unlikely(mm_is_oom_victim(mm))) {
> > > > -           /*
> > > > -            * Manually reap the mm to free as much memory as possi=
ble.
> > > > -            * Then, as the oom reaper does, set MMF_OOM_SKIP to di=
sregard
> > > > -            * this mm from further consideration.  Taking mm->mmap=
_lock for
> > > > -            * write after setting MMF_OOM_SKIP will guarantee that=
 the oom
> > > > -            * reaper will not run on this mm again after mmap_lock=
 is
> > > > -            * dropped.
> > > > -            *
> > > > -            * Nothing can be holding mm->mmap_lock here and the ab=
ove call
> > > > -            * to mmu_notifier_release(mm) ensures mmu notifier cal=
lbacks in
> > > > -            * __oom_reap_task_mm() will not block.
> > > > -            */
> > > > -           (void)__oom_reap_task_mm(mm);
> > > > -           set_bit(MMF_OOM_SKIP, &mm->flags);
> > > > -   }
> > > > -
> > > > -   mmap_write_lock(mm);
> > > > +   mmap_read_lock(mm);
> > > >     arch_exit_mmap(mm);
> > > >
> > > >     vma =3D mm->mmap;
> > > >     if (!vma) {
> > > >             /* Can happen if dup_mmap() received an OOM */
> > > > -           mmap_write_unlock(mm);
> > > > +           mmap_read_unlock(mm);
> > > >             return;
> > > >     }
> > > >
> > > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > > >     /* update_hiwater_rss(mm) here? but nobody should be looking */
> > > >     /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > > >     unmap_vmas(&tlb, vma, 0, -1);
> > > > +   mmap_read_unlock(mm);
> > > > +
> > > > +   /*
> > > > +    * Set MMF_OOM_SKIP to hide this task from the oom killer/reape=
r
> > > > +    * because the memory has been already freed. Do not bother che=
cking
> > > > +    * mm_is_oom_victim because setting a bit unconditionally is ch=
eaper.
> > > > +    */
> > > > +   set_bit(MMF_OOM_SKIP, &mm->flags);
> > > > +
> > > > +   mmap_write_lock(mm);
> > > >     free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEIL=
ING);
> > > >     tlb_finish_mmu(&tlb);
> > > >
> > >
> > > I ended up with the below rework of "mm: start tracking VMAs with map=
le
> > > tree".  Please triple check?
> >
> > One small fix in the first one.  Suren found a race with the oom or
> > process_mrelease that needed the linked list to be removed here.  Pleas=
e
> > correct me if I am mistaken, Suren?
> >
> > >
> > > void exit_mmap(struct mm_struct *mm)
> > > {
> > >       struct mmu_gather tlb;
> > >       struct vm_area_struct *vma;
> > >       unsigned long nr_accounted =3D 0;
> > >
> > >       /* mm's last user has gone, and its about to be pulled down */
> > >       mmu_notifier_release(mm);
> > >
> > >       mmap_write_lock(mm);
> > >       arch_exit_mmap(mm);
> > >       vma =3D mm->mmap;
> > >       if (!vma) {
> > >               /* Can happen if dup_mmap() received an OOM */
> > >               mmap_write_unlock(mm);
> > >               return;
> > >       }
> > >
> > >       lru_add_drain();
> > >       flush_cache_mm(mm);
> > >       tlb_gather_mmu_fullmm(&tlb, mm);
> > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > >       unmap_vmas(&tlb, vma, 0, -1);
> > >
> > >       /*
> > >        * Set MMF_OOM_SKIP to hide this task from the oom killer/reape=
r
> > >        * because the memory has been already freed. Do not bother che=
cking
> > >        * mm_is_oom_victim because setting a bit unconditionally is ch=
eaper.
> > >        */
> > >       set_bit(MMF_OOM_SKIP, &mm->flags);
> > >
> > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEIL=
ING);
> > >       tlb_finish_mmu(&tlb);
> > >
> > >       /* Walk the list again, actually closing and freeing it. */
> > >       while (vma) {
> > >               if (vma->vm_flags & VM_ACCOUNT)
> > >                       nr_accounted +=3D vma_pages(vma);
> > >               vma =3D remove_vma(vma);
> > >               cond_resched();
> > >       }
> > >
> > >       trace_exit_mmap(mm);
> > >       __mt_destroy(&mm->mm_mt);
> >
> > +       mm->mmap =3D NULL;
>=20
> That's correct. We need to reset mm->mmap so that the loop in
> __oom_reap_task_mm() stops immediately. However with maple trees I
> believe that loop is different and with an empty tree there would be
> no dereferencing. Liam?

That's correct after the "mm: remove the vma linked list".  At this
point we still need it.  The maple tree is tracking the VMAs but it's
not being used - just checked to be the same.

>=20
> >
> > >       mmap_write_unlock(mm);
> > >       vm_unacct_memory(nr_accounted);
> > > }
> > >
> > >
> > > And "mm: remove the vma linked list" needed further reworking.  I end=
ed
> > > up with
> > >
> > > void exit_mmap(struct mm_struct *mm)
> > > {
> > >       struct mmu_gather tlb;
> > >       struct vm_area_struct *vma;
> > >       unsigned long nr_accounted =3D 0;
> > >       MA_STATE(mas, &mm->mm_mt, 0, 0);
> > >       int count =3D 0;
> > >
> > >       /* mm's last user has gone, and its about to be pulled down */
> > >       mmu_notifier_release(mm);
> > >
> > >       mmap_write_lock(mm);
> > >       arch_exit_mmap(mm);
> > >       vma =3D mas_find(&mas, ULONG_MAX);
> > >       if (!vma) {
> > >               /* Can happen if dup_mmap() received an OOM */
> > >               mmap_write_unlock(mm);
> > >               return;
> > >       }
> > >
> > >       lru_add_drain();
> > >       flush_cache_mm(mm);
> > >       tlb_gather_mmu_fullmm(&tlb, mm);
> > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >       /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped=
 */
> > >       unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
> > >
> > >       /*
> > >        * Set MMF_OOM_SKIP to hide this task from the oom killer/reape=
r
> > >        * because the memory has been already freed. Do not bother che=
cking
> > >        * mm_is_oom_victim because setting a bit unconditionally is ch=
eaper.
> > >        */
> > >       set_bit(MMF_OOM_SKIP, &mm->flags);
> > >
> > >       free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_P=
GTABLES_CEILING);
> > >       tlb_finish_mmu(&tlb);
> > >
> > >       /*
> > >        * Walk the list again, actually closing and freeing it, with p=
reemption
> > >        * enabled, without holding any MM locks besides the unreachabl=
e
> > >        * mmap_write_lock.
> > >        */
> > >       do {
> > >               if (vma->vm_flags & VM_ACCOUNT)
> > >                       nr_accounted +=3D vma_pages(vma);
> > >               remove_vma(vma);
> > >               count++;
> > >               cond_resched();
> > >       } while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
> > >
> > >       BUG_ON(count !=3D mm->map_count);
> > >
> > >       trace_exit_mmap(mm);
> > >       __mt_destroy(&mm->mm_mt);
> > >       mmap_write_unlock(mm);
> > >       vm_unacct_memory(nr_accounted);
> > > }
> >
> > It is worth noting that this drops the mmap_read_lock/unlock before the
> > write locking.  I'm not sure why Suren had it in his patches and I've
> > responded just now asking about it.  It may be an important aspect of
> > what he was planning.
>=20
> unmap_vmas() does not require a mmap_write_lock and doing in under
> read lock protection allows OOM-killer and process_mrelease to run in
> parallel with exit_mmap. That was the reason I start with
> mmap_read_lock and then switch to mmap_write_lock. If that creates
> issues we should switch to mmap_write_lock for the whole duration of
> this call.
> Thanks,
> Suren.
>=20
> >
> > Thanks,
> > Liam
> >
> >
> > >
> > >
> > > The mapletree patches remain hidden from mm.git until, I expect, next=
 week.
> > >
> > > Thanks.
> > >
> > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >=
