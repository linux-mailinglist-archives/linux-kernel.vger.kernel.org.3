Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A358DBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiHIQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiHIQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CD1DA7F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:16:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279Efkk3021088;
        Tue, 9 Aug 2022 16:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MqxLcp7pdlrghcFvsUmbmJ2leZrwCoBqlvSPys1On0U=;
 b=eUOQlaDb8e07B3Ga+ECqqiHcJmm6qDkPAbNe6Cd9R38tDAfSCjaP3kew5J8LospD3KgK
 IaWx/yo0aakEbEfbwmX3aSYOmiv70gnZ0CEhqMWduAEOP/BQ/MHP6M8bcHdYsZ+7OCMs
 U2Vf9AQCn43Lnjlx8hYwZksjq55G6F51umnuRJZZ/Nx9VZskQfglZa2/9PSz5p8AnQ2h
 O/UrG/XIJ2O0SILqw/GrK7Ne2oPfK2KdeU5wtsChSu/jeSrZTtermqnh/PpqdBokTxIC
 oEALcWx0qGqMg5dZE+rQdp2vkJOTrcXoeLWwZhPdY5pN3ScDulmRetbq537s15g0jWjA cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsg69px75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:16:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279FexsI014037;
        Tue, 9 Aug 2022 16:16:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser92sdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbPCrB22m48u5OtCIn5COAT+43yOPUObcd3GDURCGK1Geqmw+K9e14MlRKzQUPAkv7jjDnZqFQC31r/PjiQqCnbfGXioMSp2UMkSh32Oqgo2SR+tECHgW3wi7PbL0zHN7O8xcAtmOJe7yY/WCdtFq6DTD6pg37IpJN5GHjrYoQ/LM2EwSkEbyKDA2TiS6x+kySKziV1rCVEFbjsyQyOsBB4H6jM6Iro0Ari908H2AUCrsphS5KH/01bVU9VZu1o53ltWEdZqZ9gW8CQpCM80eaPpoiMyUMs5Or431Vt8bwFmoHoRLwMxx92oP9N4QhFa/N8DLonyYGBRGh3wCo9PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqxLcp7pdlrghcFvsUmbmJ2leZrwCoBqlvSPys1On0U=;
 b=FgZtaRcm8iZ3lPwWil/BBQuRM5oT9mjKMWW5o8TMLA+pqgnTaGIj5PdmUKqUL2ajIsFbwCkoCwZqFCZReOR/N2TiZRenaIPFVV8Nofo8K+Cwi9Wt5+04ss7Swe19KyAt/BFIkJGbLMwjUsWWYbl/gT/dknwID5kFn46+/t6qK9vA+IMGOsRFYCwbQyJYZpsSdvTB0+xqkf20US2LojLDmUosmpBu5bq/NwJ84cCj5F7y3JKDHhP0Yt13cWMd4vJz5E9qXsjn5y5984HitqQn7qz1LfTgsW/RhDUaGUgHMvOM6poqNNC3FCKL57nS3QrDDvDnJULPXs75M+lp3N/HHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqxLcp7pdlrghcFvsUmbmJ2leZrwCoBqlvSPys1On0U=;
 b=x4ZGrPQDeHb1+v2CzP7k5q0mXBhYQYye7g3XK98BiwXYLdPS6C7STBnz8/g3KCFp6LNNuDombJ+PFoDyReQbPRNwu2L1vP7W/wEYP0tRNw9B3Zhu6MSwOujGSY06GGp+2uggMlyTNEXKheOBR14cUX98yg/ubR4F3yue2omBaTg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2175.namprd10.prod.outlook.com (2603:10b6:301:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Tue, 9 Aug
 2022 16:16:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:16:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: Re: [syzbot] WARNING in find_vma
Thread-Topic: [syzbot] WARNING in find_vma
Thread-Index: AQHYqvlZndy4dcl9OUWMjKq+hi9Ih62lZXyAgAAyHoCAASkXgA==
Date:   Tue, 9 Aug 2022 16:16:10 +0000
Message-ID: <20220809161603.65enspb45xcmblc2@revolver>
References: <00000000000085cb1705e5b5d9f6@google.com>
 <0000000000007cda2705e5bfe389@google.com>
 <20220808153243.6a80c73ce4f14c50efef086f@linux-foundation.org>
In-Reply-To: <20220808153243.6a80c73ce4f14c50efef086f@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c65b0964-2f0f-4f61-475b-08da7a2278eb
x-ms-traffictypediagnostic: MWHPR1001MB2175:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7JHIqTa7K8RkZgDh0G8cLTiORQJbp1+FUWX6NXGx3VzjU5PYqjge23gjbEVADtkfojCMTr67FDL/7p3Jr/6Ue59RUI7COUFQRHCRI5+bUjEBYD1sgrl5Cmm1WR4ewuoC6qNDJIlT3GejFVh+aB3RixXeKirSqC/4sUDEaH1fDWZuye3RNMnM4dapBS3L8qF02d2UOnY5pieHeeXJTzB1xdz2GAOJTdXM50rFXTMYx8Rgrre6fifUzmBQIAlHaYWihX/+nLQaKnXI91m64FebSUc2CwSarcixX+vABl8pCUMwFm2jPfz0hWt3ZRSYRk7z1+gb5xS1Qq56P/Rxk9rmidk17VPKPaPbzTHLon6RceqTueXd2bj4HwDITL2wSJBAvLDUJxe9ZmgmOx4pU+4fs9yfC4502LyItEtk3K7A4q8dXFcQwrsUSaV1UpSx2ulur7WpgmsrmQbO38Wxk+XfDijKbFPdbymQ+SunDGd1Ute5hZ8xuhCmj1MHXx61S0VeJLvKKqKM4/rgrVDVsprhGjPHrqf1TlKBmawsWSuCKD3Fpdrv4uUS2LBiz8iogHzBYDl9ejUaPSJIZtNkW8K40zfalaS8GuNK9+B6zBiCWdSG2m0dA67NO3dVkA3hx5Cj3TV6G1BC8OKBw3R97aK5foMl4YnvaNqFsZlzCZ2zNoIwCeVhxOCM8IK6tswV4G9EWVreD0Tp0Thdjd5B7MpJZowibbi3o0rxUhraQ3bAj6RkNx8i/i+75ZgBdCuBjvP8o8VXGCPdYcml5skjTNUIcSxSOAP8WZr3FKToMig1OfpFYt0pQT68zsy+rACxKA0WB39btnvyk8KJEbWQAO9TPd2jSbVo/211SRzYWDn8UiCOeIjl7OrCT7vr0W4WBfA+5dKYdao7RBoTAMqTPFb6DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(8936002)(6512007)(26005)(9686003)(71200400001)(33716001)(7416002)(44832011)(2906002)(64756008)(45080400002)(966005)(41300700001)(86362001)(6486002)(6506007)(186003)(1076003)(54906003)(478600001)(122000001)(38070700005)(83380400001)(66946007)(6916009)(91956017)(316002)(76116006)(5660300002)(4326008)(38100700002)(8676002)(66556008)(66446008)(66476007)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jksAgKdjNGh9/Ib+ubu2gxa79NaJ3jbk9wQA7Sbxs6EKmKjWugZYSvI3Hd?=
 =?iso-8859-1?Q?1uV3wQslDeIq50/CnFneqdXD8pXwYnsIdJWudtZoraKXBkTvgpfiRDowBn?=
 =?iso-8859-1?Q?HTf2J2JYQ3EqZ+XAdcjBeKiDqlIRbYFPls1NXcbCVITRkU0UekgGAp/5+u?=
 =?iso-8859-1?Q?IVv7ETuri6/n+W2awhBCGNTOG7rDYmj0Swxt9SC9aUmEO/LOMJqnclbMuJ?=
 =?iso-8859-1?Q?W8krkg0d9iwIe1XK6drrZoAhZAu3XYF8xLqjmhieShDkXAkHCkPDUxuO8M?=
 =?iso-8859-1?Q?DGXcupt3nf+8sFCq5b848r+LYbekcZcJsaAjgAObfrwNvq24HNsO9fAc2S?=
 =?iso-8859-1?Q?ZpIuWM0Oq4H6dtDoh/8xs4CAzkp1m0ME2f7cSrwrwYGj0fPSPLt5WsvV6C?=
 =?iso-8859-1?Q?CC7EYNQXBr5L/5j6nb/iZVDigoi4lTXNsnIam+r28FbWe2bniYHYICHIWM?=
 =?iso-8859-1?Q?031S/7SBWvQMjjYzVLjPlMOJiWtr7AVj9e7/LeIiuj2aAR4SuyAEEi4Mnb?=
 =?iso-8859-1?Q?AAqAnZLTPcpXFEO7so3Cho1hDZf2jtSzrsH6YneM+0zxQkOnlpiUC676Gg?=
 =?iso-8859-1?Q?fZj6NAJUoRYM4yFC+sQW+DQWmlRDOwMd36y6A6zKWoguQs+uCOYUKwsgL4?=
 =?iso-8859-1?Q?KHcpjizHViyAsDZbXdyf/vzFQjbyVqPuXdMtbtfVlnt1ftAyMj2v9chtRb?=
 =?iso-8859-1?Q?DegvjvLlllvQlRFG1XDG1HCq8z/tfd+zCrzuymG12sxIzUK9hQPS7Gu0lD?=
 =?iso-8859-1?Q?ZmP2y53yTCiaAJMYRzCdA5df7DwVFbw0PXHzIUohtiIYceH9W1lp5G/ZVU?=
 =?iso-8859-1?Q?i2mqev6I8bUQUIImP14JmzjqaXotXZB+r64U10KHv2N7MxuA1IPmd2Ruyt?=
 =?iso-8859-1?Q?UrKgt6XhkAiXWz/6USJl5Y3fyCuHRf2plEMoYhiCc0YzS4blyzLlyHaWH4?=
 =?iso-8859-1?Q?wZuGWpdlQr+T8LX4upsktskI0lMjPnjuyDMQ8Sla/PeI2n/YnEcjWTur1K?=
 =?iso-8859-1?Q?kygliD5SHqxC9EfPq60q6Q8zJMMh4tVrT7g4boVdBgtGpn2hu1N330bI/Y?=
 =?iso-8859-1?Q?+euWBvs6rWDjXQFJ4ojd2tm3JMlQPWfHKfrKnbX1vYKyhERX1MGQshFTWD?=
 =?iso-8859-1?Q?f4KOwQnhVFAWsVVzlZatcfYolSALmBQF86XHkGdmld9lXWIKoLMUxAZ6GA?=
 =?iso-8859-1?Q?ex6jc6h5uvHI4XB+Ua+Db/ogV46oEgpXlJ70bJ4aJ9vVWLMWdpeoRgSUHa?=
 =?iso-8859-1?Q?cv/pD0gz1gGxQEET510aA+86ESVSzrlQHUeDgAjcNgfkrdBKM7DW3AnLsC?=
 =?iso-8859-1?Q?5Q4zIYxVGLrx8NmYE9KWVj0i/wuvX5sjtNMFqtXgEfWjmumPXt4b+Bz32+?=
 =?iso-8859-1?Q?sGRR3jks5FCwOc8g94VxThx0HIKHBRVQXcc64OmKiEe0I9sAHmpAN3zUfK?=
 =?iso-8859-1?Q?3hzqwY2WKncIdu1uvkiytrPxuvU7aQ/kTMCEUn/F+RNRI1nXB4W7m7iJRo?=
 =?iso-8859-1?Q?5j6MTfIt9NQMBKGtfq7msqo6/uCKUrGanEUKNM2lNNHR2zMwOqGqVrWkVf?=
 =?iso-8859-1?Q?cW4/yHCXsB27Kiqdc3c17Yf9xqcOHeMedWX8ABWX3eUuCyPhkPXtjzRL+Q?=
 =?iso-8859-1?Q?p8779eWs+NNHUBA+J2ki6k+hUHr3Guc42xKVnjPg5Tce9aVXktGGrgMA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1C8A9B4A0CC92E43A0C1ECB4E2A1276F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65b0964-2f0f-4f61-475b-08da7a2278eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 16:16:10.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz+UYPpuKYW7ePrvS886+HtVdnflZF+Nfc9iSWCfTpeSz/ZhQUtxK7In5/cSIqIckeO53NQDzmejX5Ij1wSNrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090067
X-Proofpoint-ORIG-GUID: CiMie8l2fz3yVFBTrlh0J2u1hsesESxv
X-Proofpoint-GUID: CiMie8l2fz3yVFBTrlh0J2u1hsesESxv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220808 18:32]:
> (cc people from the thread "Binder regression caused by commit a43cfc87ca=
af")
>=20
> On Mon, 08 Aug 2022 12:33:21 -0700 syzbot <syzbot+a7b60a176ec13cafb793@sy=
zkaller.appspotmail.com> wrote:
>=20
> > syzbot has found a reproducer for the following issue on:
> >=20
> > HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14807dfa080=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4c20e006003=
cdecb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7b60a176ec13=
cafb793
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D129992320=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15452c12080=
000
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
> >=20
> > binder: 7796:7797 ioctl c0306201 20001480 returned -14
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 mmap_assert_=
locked include/linux/mmap_lock.h:155 [inline]
> > WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 find_vma+0xf=
8/0x270 mm/mmap.c:2255
> > Modules linked in:
> > CPU: 1 PID: 7797 Comm: syz-executor269 Not tainted 5.19.0-next-20220808=
-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/22/2022
> > RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
> > RIP: 0010:find_vma+0xf8/0x270 mm/mmap.c:2255
> > Code: 49 8d bc 24 28 01 00 00 be ff ff ff ff e8 40 2e c8 07 31 ff 89 c3=
 89 c6 e8 85 e2 c4 ff 85 db 0f 85 61 ff ff ff e8 b8 e5 c4 ff <0f> 0b e9 55 =
ff ff ff e8 ac e5 c4 ff 4c 89 e7 e8 54 38 fb ff 0f 0b
> > RSP: 0018:ffffc9000cee7530 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: ffff88807c278000 RSI: ffffffff81b72058 RDI: 0000000000000005
> > RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807dda3100
> > R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f5fdf1fb700(0000) GS:ffff8880b9a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000007d391000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vma_lookup include/linux/mm.h:2743 [inline]
> >  binder_alloc_get_vma drivers/android/binder_alloc.c:340 [inline]
> >  binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline=
]
> >  binder_alloc_new_buf+0xd6/0x18b0 drivers/android/binder_alloc.c:590
> >  binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3187
> >  binder_thread_write+0x8a9/0x3220 drivers/android/binder.c:3963
> >  binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
> >  binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
...

There are actually two call paths that will cause this BUG_ON to
trigger.  The patch I've sent fixes both [1].  Besides the above
binder_alloc_new_buf_locked() call path, there is one that would be
triggered when reading the debugfs binder files.  I'm guessing there
aren't test that cover the debugfs files.

[1] https://lore.kernel.org/linux-mm/20220809160618.1052539-1-Liam.Howlett@=
oracle.com/

Thanks,
Liam
