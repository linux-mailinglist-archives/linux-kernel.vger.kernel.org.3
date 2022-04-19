Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EB5076D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356080AbiDSRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352412AbiDSRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:53:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CC13DFC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:50:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JHVvMO019815;
        Tue, 19 Apr 2022 17:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qs7FQsVKBku09SxDrqZwQTpB9AKk/v6omRRMXaPKFbU=;
 b=qgpMJHviI90J9aFSfTR61wWSm937e75pvQ9TUigSm7Ygcs+c8nAoiZga52DZUDlSXaFN
 J6XUyhXIIafvlU9t7kwPcnhYkvFLRcLTBmCxlDs66Pei/LC15Hm4qVu9q/OaNm/6KQS8
 2n0eLftn14qNapl0CkdLfx3N5J07aWRTwhPlEeQLY1bOq2VUZ+Xa1DnMNrDf9EblrUQB
 0w5j61B3yvNX/Ka+zwPB3hrpAKEUh2qcUkaUNeLctf937Zb2ScxDsCBhQcWEFSuGPJ9D
 T18jckCKVyl8ZiI96hYdXcvJFSJ1g83XtVrr/DRRPQxtu6+6x03U39PGojMrLe9O64dd oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd16uyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:50:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JHoUSr010581;
        Tue, 19 Apr 2022 17:50:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88f0xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlUKRZegW1KO5/aZANWaQRGbWGwTt0ACR/N5rG5E1iqnX855O3hNGY1S6R5no5QLiYfrmfFr51oq4imvUNMbc9S1IDJy953qq+5hCccjBcqthCcAYyt0ItVeI8L+crcbXW6YRZbJxPfl+qg6u9LANyrGjf4oa4mM2JtGnW52yZnJrAIVkO+mhTKFT1QdD0fZXDOOP5gKP2oWF0o7vVenz6cCuvDeg7AUWq2PbzCCzgIr55dh+GjmYIf4F8ofqcEgiRYOmfFMEE+bu/kirvhxYw4ek9d4d/THIC3l4GtBhtgSjIv5fsqG37zLFkgG71F/4hTht3hyjTDuTeLEtzM6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs7FQsVKBku09SxDrqZwQTpB9AKk/v6omRRMXaPKFbU=;
 b=K3dERfdPX8zjtJAqFwEP6wPnZQzZDmAXYX/IdXS3a6I6y06Hbaiz8pqoRWn4FweoHER21zdHAqgQSUaCXwxdabWymo/0eSMJLYiuRfzqd1MqwHZJQ0z3OJa2XjhMk2K5RcRxp/bM3wbC0dpVqo1QXLBrJJMewwJgWgFKYqtscrxxMSGEETkahlQbjrAzlz+YTVY8+7NS3/VNCpk8pBZC8CXxt8UzLK9qKzdDyde6p9oSPecONGpSSCCO7TPUxHasUvooWmrsFdaoX7AQ6duB0+siwSeWEhLO3wdDGjMqiNhAqTMSkPzqL0Op9lmW2lahEgvBK2NqW6E+L0aEUx+0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs7FQsVKBku09SxDrqZwQTpB9AKk/v6omRRMXaPKFbU=;
 b=tEg/Q2+gvQMytqTCt1iHyhjmgS3PunGIcOYB+KQvlpgo85+fYPCo6JE3S7o8/WrUWWujJSFH+x6ZYOLpWAVn5aznMGFcKGD/b2a9QdL7r2MmrxtHULlzoqFu4c6dHeUzYHgffjo+TgIYsWog79sF9qlUPgRLs522FxWhknUvjlM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1668.namprd10.prod.outlook.com (2603:10b6:405:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 17:50:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 17:50:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAH6o6A
Date:   Tue, 19 Apr 2022 17:50:37 +0000
Message-ID: <20220419174757.2tptlbkebiletmck@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver>
 <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
In-Reply-To: <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7500333-abcd-47a3-7e3c-08da222d1cf1
x-ms-traffictypediagnostic: BN6PR10MB1668:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1668B5EA4AAFDC4928555C09FDF29@BN6PR10MB1668.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLNXhus9P5jLnAw/gytk/3VpsSVWaC3WEyYv3OrGw9u4mu/DEajeAZPDcK01yxgdYjfrjPvhzLyFf0ggBMRfQmweHCYd0lYE/FhshOIuClzCdVGREYHXYtakIIrPQzxgFmar7nV27N22naThMxGk+inel0mmMChrdkk/mr0tTXvREuXROqBRYnHhDgpgw9JxKXvSswsmfnlS3L4u/lpTgIOmA5enfOfOaFi1HGc1QScmR+rux3B0u82U6l2pgF34XX0z/7oc1I0nBmtbXTEyAkqbE7+dftjcgdwkXNgXdRqWIZ9FQR9S2eTw8FxixjWwFBgVyh3PzhqCulslzAavU6pKtyy7XTtIMKjP/ssoE8P1qRBcAnY5osxtCIqbt3Azff66ZTJ8SGAXPAkDO759q6ZLamsI1G/lePinOUoV08KyeQXJHtGurpYPvU257KFiaQJ0hsRD0fTg0pQpN/RLsOAPOBy3pWf/nsCBcJUns6Lostg2Lyb4k6k89AiWrS1N2wzViN5Crn7NHcnLlSKykAXhfikaF1BzISuc6o0ZgJPtu7mjgmEd8bRbdbM9FMvyWTTjStmjs5qEXXjPOhtXMoGwKgYsZFy+1Kmas0SjDNvFUMQjpUpS+XfF2Q+y4vD8oQKLieuIBO9/fb/1hfTl1eLlWCTd429AL3aj8ZmXfP6zVyyL4knfrGErQSi1aZIb/IMDWh7+gc/vIWXIvr7xra13frksMT6XhNCHXvRmQ8Jwq54XWdA1HXqCxOIrep2S6YpZHmpG8xwwdfoLDC/gIfxfB2+g7jiU4LYRbJUOeVOpgZKPOkUZT2ddN8nrQY7chHi1aXSkycHsK9l70/AtLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(71200400001)(1076003)(26005)(4326008)(66556008)(8676002)(9686003)(6916009)(86362001)(8936002)(5660300002)(44832011)(6512007)(122000001)(99936003)(316002)(83380400001)(91956017)(76116006)(54906003)(66446008)(64756008)(66946007)(66476007)(508600001)(6506007)(6486002)(966005)(33716001)(38100700002)(38070700005)(2906002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DXg90TeB/iQI3Kvia/zYAks5M3okkgyfhf8w13olGAp++lGdF3YExB2jq8iD?=
 =?us-ascii?Q?K/HiZ4qrnZJwtBrDO86Ul4K4MVA5+66vyparBEYhJMgkL8Ew1jhq4QfhPzjt?=
 =?us-ascii?Q?WCHw+yP1zndJEVGrYHlK6Saw/qYuKb7U6jzeIGHyuYRGYb1b7qGUMRZghEiZ?=
 =?us-ascii?Q?tPrDSIQEJ1F97AoD/otK3UQRRq7JgNrI8mzQkTnvkbHBhmV8GM+4dNJqPB14?=
 =?us-ascii?Q?ZWIVih8boCttLF+pqoISt5DvhJTtL+ALafHwh1yBeBLsLOjuEyeFjDBiU/Vn?=
 =?us-ascii?Q?GRTofkmkgo4VVGEDpM7CzDgsHOA1YeRHLC3Zqw5ghmYoTPMhYDNlO16tiJ8w?=
 =?us-ascii?Q?xJNFKDiAOptF46pdcdNT34/YpH+s154JyogLhug/DK0bLhNRtJ5/b+Fuv2oO?=
 =?us-ascii?Q?q+1U+x0w7Zt+yB1ukjJztsy+P1eH0R/epQeLivt/xsmg3ly85a9/m7x2KRMa?=
 =?us-ascii?Q?psbO52ukTuKm8ACtm5m78wkIsQqCMa/llUScj371BFQPp2dFXAONF1JlpzqD?=
 =?us-ascii?Q?4s7i1jYBRyff6CX2Pv8QE7lCnQzlKQ7KV2sP4fFcgL/FNVVuzVWab7u+cjkh?=
 =?us-ascii?Q?pEWX4eR5ZQSgQXMd3hJJtmR6O5GDL9pCIopMRpeAv8TzvZGoZqkdxKRWhmTx?=
 =?us-ascii?Q?DBscU6HD7su7yHftViamI8TBHYhE87SolkSqcWQVAm8BQN8IZULh4iKM4zHe?=
 =?us-ascii?Q?EwvV2OrN+JU+0gaT2go5zVBi44G4reI7z30p0aE6+T5FynYjHE/jxl3+9B9g?=
 =?us-ascii?Q?wtyrlTa+qfmCLcigpvTFy272Hb6zmFJiyvl+xh55Zu0EwOokaq7hSnVuTZvT?=
 =?us-ascii?Q?0BStk9dPNtqiGTiiajk4xJnRKEVl6+Q7YUk11ZS5kkWH4ny1lvyik5Sgp1c8?=
 =?us-ascii?Q?NoJ2o1ykCNK2mOTM1YqeHBieHJ2YcY0hMQNoWX+o4ttvzJmtHC2CV2+D/dY4?=
 =?us-ascii?Q?+15ZkJU1tOcOcNAoh9hR2JHVyh5AwHFjzRLH+rs6/QweVXs6w7L7K9KG8w3n?=
 =?us-ascii?Q?LkQb6ExSyQciCMEeqjlO56n9nuYT9xwfZpRr3WcFA5HB473GfbQn8Av2I5E3?=
 =?us-ascii?Q?hJz4Hu2JZca06mNybWtXKIiW9D6j8Xcw0JxOsyMP2hGzMZk2DDSqqjyEXte7?=
 =?us-ascii?Q?R5LhLqflloeK1pOclTpNxLq0MDS112LWFIFTdMw2kmQ8tBbopIVcWiE9aWvU?=
 =?us-ascii?Q?ky2+mMUh83iB6ApfGH9WYfWhUxI6k3EH4y93gU53CuW2RvnO1PR0pxmyWc6z?=
 =?us-ascii?Q?0R0T5srZdltq5RTyFYX3ijnPCh5UJhITJc+9x0HfbVgM+m/kmwC+Jjcs5TQE?=
 =?us-ascii?Q?HLhJf6Hae1cyQM+GvM5BXTvIgxvCTGwjMuDr70A+2kUvWn6otrWlrxLEh1BN?=
 =?us-ascii?Q?00YotMmj2f9pV81UpKHXsXfoqj+Gre7+Xjj5k/CCIqkKmH+iReOHrBfFcujd?=
 =?us-ascii?Q?IstVIWljUWxTm4sbPaHGCAtVVZtlrBvzIK9s7Z74rG2DoQFdUPJdqeGmLp/0?=
 =?us-ascii?Q?FGGM6DvqaorK/dqiwc3fw5ZNvDIS+MsDy7K3qt9PWT7ECmQr7YbTU7JclcnF?=
 =?us-ascii?Q?iPj5h40QFXwhnGk0y137dQJWcIC1eFwhlkln4R5B7be8TpSqLE3BwK7nhLPx?=
 =?us-ascii?Q?bmvY2KsEv2Tfa/jmUmPw+RHohbjgVr2YSFX9x24JLkIXmJPga2KjrXVTGW6m?=
 =?us-ascii?Q?qIP5bpUWfdFzubnhIdRageHo45HFGwLoQ9ye+jLiVg+AvuVGnBI+jg/6Isbv?=
 =?us-ascii?Q?YC+UMAatz3UGXz5la4nJoNm8D/UE7JU=3D?=
Content-Type: multipart/mixed;
        boundary="_002_202204191747572tptlbkebiletmckrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7500333-abcd-47a3-7e3c-08da222d1cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 17:50:37.9870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjLy1iDZUZy8oNi4wcskasiwsh0WBymxoGSNr/gSqGp3hValuhSq5KPW19WsgWttqu8mW/PyW8qsWHi5Hhu0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_06:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190102
X-Proofpoint-ORIG-GUID: 6ZFfXQaIBfnd0Mby9BayeupDhuckXJir
X-Proofpoint-GUID: 6ZFfXQaIBfnd0Mby9BayeupDhuckXJir
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_202204191747572tptlbkebiletmckrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C09D7FF5C9011A45B1D50A1D9694F441@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Yu Zhao <yuzhao@google.com> [220414 12:57]:
> On Thu, Apr 14, 2022 at 7:57 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> > > On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.c=
om> wrote:
> > >
> > > > Please add this patch set to your branch.  They are based on v5.18-=
rc1.
> > >
> > > Do we get a nice [0/n] cover letter telling us all about this?
> > >
> > > I have that all merged up and it compiles.
> > >
> > > https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> > > https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> > > disabled for now.
> > >
> > >
> > > Several patches were marked
> > >
> > > From: Liam
> > > Signed-off-by: Matthew
> > > Signed-off-by: Liam
> > >
> > > Which makes me wonder whether the attribution was correct.  Please
> > > double-check.
> >
> > I'll have a look, thanks.
> >
> > >
> > >
> > >
> > > I made a lame attempt to fix up mglru's get_next_vma(), and it probab=
ly
> > > wants a revisit in the maple-tree world anyway.  Please check this an=
d
> > > send me a better version ;)
> >
> > What you have below will function, but there is probably a more maple
> > way of doing things.  Happy to help get the sap flowing - it is that
> > time of the year after all ;)
>=20
> Thanks. Please let me know when the more maple way is ready. I'll test wi=
th it.

Here is a patch to replace the fixup below.  I suspect we could do
better, but for now I just used a VMA_ITERATOR.

This could be put into d2035fb88f9f "mm: multi-gen LRU: support page
table walks" if multi-gen LRU goes in after the maple tree.


>=20
> Also I noticed, for the end address to walk_page_range(), Matthew used
> -1 and you used ULONG_MAX in the maple branch; Andrew used TASK_SIZE
> below. Having a single value throughout would be great.
>=20
> > > --- a/mm/vmscan.c~mglru-vs-maple-tree
> > > +++ a/mm/vmscan.c
> > > @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
> > >
> > >       while (walk->vma) {
> > >               if (next >=3D walk->vma->vm_end) {
> > > -                     walk->vma =3D walk->vma->vm_next;
> > > +                     walk->vma =3D find_vma(walk->mm, walk->vma->vm_=
end);
> > >                       continue;
> > >               }
> > >
> > > @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
> > >                       return false;
> > >
> > >               if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_=
end, walk)) {
> > > -                     walk->vma =3D walk->vma->vm_next;
> > > +                     walk->vma =3D find_vma(walk->mm, walk->vma->vm_=
end);
> > >                       continue;
> > >               }
> > >
> > > @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
> > >               /* the caller might be holding the lock for write */
> > >               if (mmap_read_trylock(mm)) {
> > >                       unsigned long start =3D walk->next_addr;
> > > -                     unsigned long end =3D mm->highest_vm_end;
> > > +                     unsigned long end =3D TASK_SIZE;
> > >
> > >                       err =3D walk_page_range(mm, start, end, &mm_wal=
k_ops, walk);

--_002_202204191747572tptlbkebiletmckrevolver_
Content-Type: text/x-diff;
	name="0001-mm-vmscan-Use-VMA_ITERATOR-in-get_next_vma.patch"
Content-Description: 0001-mm-vmscan-Use-VMA_ITERATOR-in-get_next_vma.patch
Content-Disposition: attachment;
	filename="0001-mm-vmscan-Use-VMA_ITERATOR-in-get_next_vma.patch"; size=1934;
	creation-date="Tue, 19 Apr 2022 17:50:37 GMT";
	modification-date="Tue, 19 Apr 2022 17:50:37 GMT"
Content-ID: <1F101A7DE1DEBC44BD17ECA4912FBAB8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAzNGFmNmRkNWI4NGVjYmUzYTBiMjBmOThhY2I0MDM0ZDU3MDg2ODVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZz4NCkRhdGU6IFRodSwgMTQgQXByIDIwMjIgMTI6MTY6NTcgLTA3MDANClN1YmplY3Q6IFtQ
QVRDSCAxLzNdIG1tL3Ztc2NhbjogVXNlIFZNQV9JVEVSQVRPUiBpbiBnZXRfbmV4dF92bWEoKQ0K
DQpUaGUgbmV4dCB2bWEgbWF5IGFjdHVhbGx5IGJlIG1hbnkgVk1BcyBhd2F5LCBzbyB1c2UgdGhl
IFZNQV9JVEVSQVRPUiB0bw0KY29udGludWUgc2VhcmNoaW5nIGZyb20gdm1fZW5kIG9ud2FyZHMu
DQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5j
b20+DQotLS0NCiBtbS92bXNjYW4uYyB8IDEzICsrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vdm1z
Y2FuLmMgYi9tbS92bXNjYW4uYw0KaW5kZXggZDRhN2QyYmQyNzZkLi4wZjVjNTM5OTYzNjUgMTAw
NjQ0DQotLS0gYS9tbS92bXNjYW4uYw0KKysrIGIvbW0vdm1zY2FuLmMNCkBAIC0zNjk3LDI0ICsz
Njk3LDIxIEBAIHN0YXRpYyBib29sIGdldF9uZXh0X3ZtYShzdHJ1Y3QgbW1fd2FsayAqd2Fsaywg
dW5zaWduZWQgbG9uZyBtYXNrLCB1bnNpZ25lZCBsb25nDQogCQkJIHVuc2lnbmVkIGxvbmcgKnN0
YXJ0LCB1bnNpZ25lZCBsb25nICplbmQpDQogew0KIAl1bnNpZ25lZCBsb25nIG5leHQgPSByb3Vu
ZF91cCgqZW5kLCBzaXplKTsNCisJVk1BX0lURVJBVE9SKHZtaSwgd2Fsay0+bW0sIHdhbGstPnZt
YS0+dm1fZW5kKQ0KIA0KIAlWTV9CVUdfT04obWFzayAmIHNpemUpOw0KIAlWTV9CVUdfT04oKnN0
YXJ0ID49ICplbmQpOw0KIAlWTV9CVUdfT04oKG5leHQgJiBtYXNrKSAhPSAoKnN0YXJ0ICYgbWFz
aykpOw0KIA0KLQl3aGlsZSAod2Fsay0+dm1hKSB7DQotCQlpZiAobmV4dCA+PSB3YWxrLT52bWEt
PnZtX2VuZCkgew0KLQkJCXdhbGstPnZtYSA9IHdhbGstPnZtYS0+dm1fbmV4dDsNCisJZm9yX2Vh
Y2hfbXRlX3ZtYSh2bWksIHdhbGstPnZtYSkgew0KKwkJaWYgKG5leHQgPj0gd2Fsay0+dm1hLT52
bV9lbmQpDQogCQkJY29udGludWU7DQotCQl9DQogDQogCQlpZiAoKG5leHQgJiBtYXNrKSAhPSAo
d2Fsay0+dm1hLT52bV9zdGFydCAmIG1hc2spKQ0KIAkJCXJldHVybiBmYWxzZTsNCiANCi0JCWlm
IChzaG91bGRfc2tpcF92bWEod2Fsay0+dm1hLT52bV9zdGFydCwgd2Fsay0+dm1hLT52bV9lbmQs
IHdhbGspKSB7DQotCQkJd2Fsay0+dm1hID0gd2Fsay0+dm1hLT52bV9uZXh0Ow0KKwkJaWYgKHNo
b3VsZF9za2lwX3ZtYSh3YWxrLT52bWEtPnZtX3N0YXJ0LCB3YWxrLT52bWEtPnZtX2VuZCwgd2Fs
aykpDQogCQkJY29udGludWU7DQotCQl9DQogDQogCQkqc3RhcnQgPSBtYXgobmV4dCwgd2Fsay0+
dm1hLT52bV9zdGFydCk7DQogCQluZXh0ID0gKG5leHQgfCB+bWFzaykgKyAxOw0KQEAgLTQwNjIs
NyArNDA1OSw3IEBAIHN0YXRpYyB2b2lkIHdhbGtfbW0oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBz
dHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IGxydV9nZW5fDQogCQkvKiB0aGUgY2FsbGVyIG1p
Z2h0IGJlIGhvbGRpbmcgdGhlIGxvY2sgZm9yIHdyaXRlICovDQogCQlpZiAobW1hcF9yZWFkX3Ry
eWxvY2sobW0pKSB7DQogCQkJdW5zaWduZWQgbG9uZyBzdGFydCA9IHdhbGstPm5leHRfYWRkcjsN
Ci0JCQl1bnNpZ25lZCBsb25nIGVuZCA9IG1tLT5oaWdoZXN0X3ZtX2VuZDsNCisJCQl1bnNpZ25l
ZCBsb25nIGVuZCA9IFVMT05HX01BWDsNCiANCiAJCQllcnIgPSB3YWxrX3BhZ2VfcmFuZ2UobW0s
IHN0YXJ0LCBlbmQsICZtbV93YWxrX29wcywgd2Fsayk7DQogDQotLSANCjIuMzQuMQ0KDQo=

--_002_202204191747572tptlbkebiletmckrevolver_--
