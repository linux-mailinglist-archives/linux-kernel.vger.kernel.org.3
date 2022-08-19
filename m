Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D7599D15
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbiHSNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348619AbiHSNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:40:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10BF9951;
        Fri, 19 Aug 2022 06:40:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDYIH6016189;
        Fri, 19 Aug 2022 13:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8Dn6kNc4JG2xI4Epr8QhHwc8BhlPNIVU6N85axaZ0Fk=;
 b=WbeJpY+q+IbUbN/6MTUHJXolo0/GhWRs6WcHJTzbxt8xmGjmCuD34Je+lKxbgcWQeqNT
 5IeRAz2bm2rU2nbuz1btwpebC3hF5+meyofA216QPjrMb8w3zunb90b5tvXQt1TWUulF
 RL3RUs/aCLNGkenossrDF5Fc08bwvB36KDZWOnNJ9/FBtxzRz4SPP13n9A9y9ECC5HIZ
 JUPGvCt9ncA3CJX6K5IiUg5eo6L+r0dB792NBAlj1CzWa7QCshw2f+h0BwlLDM2qUDXI
 6P3BpLEuvHmyysbQetsm+QKmUqd9y7q6HiBEUInUPO6nKb6Bjf8oKLyT+kvj5vR9mRi7 UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2b3pg2mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 13:40:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBVOkC031997;
        Fri, 19 Aug 2022 13:35:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d5gvhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 13:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgaC/uyYtfjPzQdt8/a6i5IqizZmoYokYVbIht4u33Xp1pJw2IopUF8RJUwlubf+7zOsZ6qAGZkOvpErxoGbolVGGpEso1LZZk/nmT7oYMDwOF3easJuyHaFaEaVl+SMgJbkQXwiB4vNjOZXB1x2IkrPPK68AEC9aCVs7LcNCrLX8zYADb9e9udiJdncOXZmV2Ve0MfWln5fU9ZygTuk0VlSW4pPiPnMxtQwvYGu2DxBCnuATALe89uRs+WOBpHvbs2pebi2uj0Sky6b03HbRH65KuQnJ/2mZw6zMrJ1Db62omGEIWoI4cbFux8zIF/9ZVarIadK3lOfmlsZhEEtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dn6kNc4JG2xI4Epr8QhHwc8BhlPNIVU6N85axaZ0Fk=;
 b=cDNFnS2y9QEZLlCJiDvaXCFJCKgrwXLeuxzWzvFGiHMQp7noL8f0Zo2SMbA0sGudSsE6nqY6UK3Eu9Tt+QdqteT4r2rSpDMbIDv9EJ86y/xlxFffwZ0hOxbaHOJEJ7dfZEg9pxDXN5xSUhyS4PlECSdu6xanv1vZZrBzsvkKCQmXqoroe/FZUhBEX8uPw/JC9ZfYoJ7xG7W/hSzDRXImgUhDiP5/4NzXDZgNXwLXvROdwEAdIeEODguQByNv6UMIybXqu1uuoFlp+KUyHrH5dMBu70QFhwDg7YKfvy2rhzC6baK6jsjq/UdM99FuubK4dPAoJqUeCz7T7f4vj3rNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dn6kNc4JG2xI4Epr8QhHwc8BhlPNIVU6N85axaZ0Fk=;
 b=zco/doJhT+fq3rL/L/J8xa4nV2Mcvuy3AfLFrXjXUs6N48iU2AsbnZQVEDtJ3Uz73RYyg2rdK16Ka/3aJiNShUxulk73SMP3ii0gCh9NYqdql1aVFATWX43Q90VmoF06JgsXZehrOIzxEcjDubJtyhmxccOVxCSgxGoFgp/6rTA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4053.namprd10.prod.outlook.com (2603:10b6:610:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 13:35:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 13:35:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Thread-Topic: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Thread-Index: AQHYs1HbDhYfYQ0XCUKcG+3NKBkWE621xVmAgAAirICAAAQ1AIAAThUA
Date:   Fri, 19 Aug 2022 13:35:04 +0000
Message-ID: <20220819133458.eqshbr5xp4yr3xws@revolver>
References: <20220819082714.5313827d@canb.auug.org.au>
 <Yv8vZQB25NE0r/uN@kroah.com> <20220819184027.7b3fda3e@canb.auug.org.au>
 <Yv9QArukYhIgg3R7@kroah.com>
In-Reply-To: <Yv9QArukYhIgg3R7@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3811ffef-c7fd-48b8-1f13-08da81e7a00d
x-ms-traffictypediagnostic: CH2PR10MB4053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hs0l2UArIDDOguS6cxqhpHNuDIoHRqjRo6FC6YE/2tqBn8lbZaBRAh+jP5oiDBLh70NDowG1gvwIKDrXlMIn9vLYirgeI9rum7S/ZY5qpEDpM+YxeYduYngupsVcL3KawZuRXLiKKFwLonIbM3oQvDHiSDD+RqMQLrXg4UJp5s8liXinhfIPH/fru8eQtGKFswi8eucOoPLb3+I59LOEM1Wkj7yzD4YImzODFO6oIacPb1Yq24DrZs6eFkO58XvUCFjRrZO0ZRvdK9upHMNW0ggtU3YIZqbLQTgCzEE4NMwCgn8S8hzDHF6umFqD4Ej5qzPLacBcw6x37GUfSuauySM+tdXOmfw4kAl97n1ip5/B3b3lzS0duRmYood6aVoaJRJTj99d1+u3qRdt+foGxXLOaWkIdecr3ElHqydekvzv+IooRaUPjN0MG8is74bGkdPgXVJQDMB7ecHhRkFHfelmXy13ljldH/lNG9nmx3NxiQNwGpJuGfKC07N88ZjqR9Q+WX4Exb4UpO5v0MGOM/QUUmaIi6sxeo26/7IH+ENl2YknfioSsGEFvBOhnGwQl4y4oMQKCpceUihem743iwS+fiFkT3WpDuba7WOeEby/XF6actdffhTQOLu759YP1UFr2KnkEn9gZXVxCLk7VBwbmHHYuGullar2akSgUnXbwzDZd18LpVGh1nv7Bng7GsSXfNH0td2sLgvvYtn92cH2/2KLtsOFdSAXFAFfVrmAr2ukzmfrkpdx0mbLReiRiv+Q8iY123MMfI8qjyOXbTYbI1kol1gqGg47Dwejq7owuf24uJ5I3SmMoaqGfcidGY/XovBVo2eTavlYSRAANQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(376002)(346002)(396003)(39860400002)(83380400001)(1076003)(66574015)(66556008)(186003)(8936002)(44832011)(76116006)(66946007)(66476007)(4326008)(8676002)(91956017)(64756008)(66446008)(2906002)(33716001)(71200400001)(478600001)(45080400002)(966005)(26005)(6506007)(9686003)(6512007)(41300700001)(6486002)(86362001)(122000001)(38100700002)(38070700005)(6916009)(316002)(54906003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VMAF6x0tbxQcSrXdxlOQbIM9e9AQf4Vge30K8eH0lsorslzJbGY63SwpsB?=
 =?iso-8859-1?Q?wWyosixRh0EK03wvnl3JZC0vk2Alnc+NOFq0AaP+UFjpfxqBYwkqR3W+kj?=
 =?iso-8859-1?Q?UBk/8OdnlWjnEjJVVXOZXSuprk+Nm0K9DLgaI/9ig0sajeSS5G61km2wue?=
 =?iso-8859-1?Q?kN6fenx2nRd6Eb6VzjB2A0Mij7R0u61w5FX+BSREDWH1xpnlAUyzv4b8YV?=
 =?iso-8859-1?Q?WBbNt9CGqYPx4hTUHoX4aNAwEnc2hGIVs5119PBBHYT5UmW+6y1UPs8KAg?=
 =?iso-8859-1?Q?4mqn3/Rc6VJdIp7ylc0uuk9HwlxuQeLTdefcpLwpOGCq30Xpe/yaJk8wBl?=
 =?iso-8859-1?Q?gQxYJx3Y1HmcHiV0MOZJCcALOIUdhAQeYQM0H0mJ1whgRFfjV30BLscq1z?=
 =?iso-8859-1?Q?coOE1A2Uon781f4ea5aEVzjoc1lKJFgEhmRvoDTCmsxcw2CMMbm1D28OFP?=
 =?iso-8859-1?Q?h6i8QT2llvJNy9RgfH9Nyl24enyouNQeFq7dXfpy6C51UYIFcAOtddOhOZ?=
 =?iso-8859-1?Q?gP8B5mg6u5QDlP0foDat7HsetP+w1MU9X9ZYSh5ljrm7okITPBZS+h2qGE?=
 =?iso-8859-1?Q?sWBgxRTGULBpeeHUZIGb1klA8WQAi5BXcRuCrL89w//tcWZwdk0dir78Ss?=
 =?iso-8859-1?Q?SC8PBQnpKChJz023fIXNY2mCq2FMCARNHjKuzWznUxPEFGedKg2ET8VfY6?=
 =?iso-8859-1?Q?+Njy06vEW0iRr17dhICiqCAiSCS12vNxHYmq90J5a5yTPuXdYQVUVATFEl?=
 =?iso-8859-1?Q?XG0quabTAQjIfr1bxVvJsaZlHaavOzABchRDLNM4qrU2LSDGzcw1riM5Tp?=
 =?iso-8859-1?Q?oXkKkEgL5KpQL415kdUe37uhOwy8j7Nfsar/CYirfdke6K/bxc7Rm+4Ojj?=
 =?iso-8859-1?Q?9b9B0I7uHiMo6QuV+ATQrNyBlBGov6QVzhi8686LbfwEdp+3AucTQAeQHo?=
 =?iso-8859-1?Q?JvlsfzDR4W2rs3i33fYcwTYrUGLrMl19brn087nGaOtTEmruH7seJ1THI9?=
 =?iso-8859-1?Q?jyMzgEiSDU2Ib9DSLPCS9qlirvIsHaqNQ86Czm1Nah5baZLMVx+vSN2KS8?=
 =?iso-8859-1?Q?xVg89JnVWUxhDQcmCuY8ZUm0E9OrdzNHR1XUpfqcH7VPqSS/z6FNVMQ5BU?=
 =?iso-8859-1?Q?usX0sSJAvl08P6tRScjemW0O7VvYiQp8jiBJDN9pDb+6s3dIZJByHRYR5J?=
 =?iso-8859-1?Q?RwhlerbNuAVB9LD27p1QaC75CiLrJJNnlUgou5pZK28YICwSN7GvG5oCzI?=
 =?iso-8859-1?Q?7uNJG+u3hpWntPBxen7tVLVpZaxhhEdv+oOA4ncnqMzGGABG6ewZLWD9ha?=
 =?iso-8859-1?Q?xRwNwPeKYKqfs3O/spdq9d7C0iIK7Z1w/2rueC51yx/Uh/zo+QPDzDs+rI?=
 =?iso-8859-1?Q?PBuSAVPL4ciKgbchpslSKJ1q1ERmQ6iezazm39DudF2mDRw1Sn7sDXKMFG?=
 =?iso-8859-1?Q?qETscuKftD3QIppn5vkDZJHZvNxHh2vjR+F6heVPYbuYOwE8r2dqCOV1yw?=
 =?iso-8859-1?Q?TevMALkF9YTlS76D+g72hIPfHjKzoulHpv+cj9ZH7jX6k0HBUfhrmrpqd2?=
 =?iso-8859-1?Q?Z9jofiYKYUprg+JFyqJX1W2M9wftfixJN9Fnm2rAALu5ZFxZnzGnEUW21J?=
 =?iso-8859-1?Q?Wh2hXB1qZbw3pFJCPIiZlwZu49/IvQ1QGEGSbrxBfFm9wXx+Q8tvpFZw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C3D8A1AAF71E8F47B234CB9115ABF488@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?eXRmyPTqkvSkCEWoMojCGc1SEInr4Lg8eFJS9Gco7ENbW1PGh+sJlJJCnM?=
 =?iso-8859-1?Q?4YtLXhVOA/NCROTd9U4twMUpkSd5iVnuk6tqIICLsIK2dgSm7TaFK9ogq7?=
 =?iso-8859-1?Q?bD9RhG7CRLiVjSVoetQayUPDWM5GZk+eKSFv3xRjDVEeU30W7z7FBXXwcW?=
 =?iso-8859-1?Q?d1GqhVVnrnwLlOzufTE09rp6iIKYWAH7+FOfnmGiT4XadTFFQsKCigt+07?=
 =?iso-8859-1?Q?Cjn/sOUthn0QaxKUmGAhBW7iPJezPKCNAUGpM4+uugtCZeE8wP+JK1n5Ds?=
 =?iso-8859-1?Q?B/cIJEPG99cZ/VKjg8veftE4A+ymxyDoZZSRDgz80CIYI8zNEiAElMJ3Uw?=
 =?iso-8859-1?Q?R1KRtToRlKd4c2hoiSG/TcC6kZvxA0Y9QXi0jJG3m+WnfithfDL2oxAe3j?=
 =?iso-8859-1?Q?iCsxXBXb1xstdN6xCZ466rmR50sYaoch6CXR1dKSF4GuTZsIXDImCv9rph?=
 =?iso-8859-1?Q?QkY4Kj/623FryRn1nfIwcmerorQfLPQWj2322iACbG4Oe0qSxLvpV82tBY?=
 =?iso-8859-1?Q?G5JXIbiLR0FsvEECWx4u53itfzBLiKZWvmQkS5Tw3aHzA6udiHRQb0P8nx?=
 =?iso-8859-1?Q?8JuUbv5BP2YimPUYvDjkerhuYRr9+SsXDG1+t+iLWKtoUuY6jZ4bDukoI/?=
 =?iso-8859-1?Q?AW8RnoPmDOqB7GxFP0dlxPAgUmBbcJA5PYRViBpOIta4TaHYnRUUrFMLX/?=
 =?iso-8859-1?Q?Ly8rl+vmJUyHTTfpZbj21L7chMIGHBYm7acY847CAQGgN6WBgPhoZSJ3X+?=
 =?iso-8859-1?Q?LmtN9xjwfjaZj186mhd7cm2Rzf8nMZRmQjElnbS/8Uoj8xWzrgLSTopW4f?=
 =?iso-8859-1?Q?WuogG4nJkuMhzsi2xJ8JrES/ya4/7KrSzQsV8DT+UdCjhSo8MEnre1TEph?=
 =?iso-8859-1?Q?n+Zqo/JBas5O2sqdOyW+MOZYE+u9pDucd499sVZh4NiXUIoc28H7rQ4veb?=
 =?iso-8859-1?Q?0WypCytRCJSWOSNSdpoK5LcR9mT9md1vUcgAe4XeismBdOH3suOTHrgIy2?=
 =?iso-8859-1?Q?780Ao9KAtrOT+az87HmDVI2nFR6s0QW70dt4lD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3811ffef-c7fd-48b8-1f13-08da81e7a00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 13:35:04.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBFq7OgZ0HCYhqWUNwdf2FiOmpouAFL1KsqQ0ankjWC6D2KIzVNPrOFzJ4zceafOFTzS5JN7555G8TFWnIqfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190051
X-Proofpoint-ORIG-GUID: 1HasOmoThX_OvQSHWBO2WIj02xY8Cjot
X-Proofpoint-GUID: 1HasOmoThX_OvQSHWBO2WIj02xY8Cjot
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <greg@kroah.com> [220819 04:55]:
> On Fri, Aug 19, 2022 at 06:40:27PM +1000, Stephen Rothwell wrote:
> > Hi Greg,
> >=20
> > On Fri, 19 Aug 2022 08:36:21 +0200 Greg KH <greg@kroah.com> wrote:
> > >
> > > On Fri, Aug 19, 2022 at 08:28:18AM +1000, Stephen Rothwell wrote:
> > > >=20
> > > > Today's linux-next merge of the char-misc.current tree got a confli=
ct in:
> > > >=20
> > > >   drivers/android/binder_alloc.c
> > > >=20
> > > > between commit:
> > > >=20
> > > >   b3bb668f3dc6 ("binder_alloc: add missing mmap_lock calls when usi=
ng the VMA")
> > > >=20
> > > > from the mm-hotfixes tree and commit:
> > > >=20
> > > >   d6f35446d076 ("binder_alloc: Add missing mmap_lock calls when usi=
ng the VMA")
> > > >=20
> > > > from the char-misc.current tree.
> > > >=20
> > > > I fixed it up (I used the latter as it was committed later even tho=
ugh
> > > > the author times were the same) and can carry the fix as necessary.=
 This
> > > > is now fixed as far as linux-next is concerned, but any non trivial
> > > > conflicts should be mentioned to your upstream maintainer when your=
 tree
> > > > is submitted for merging.  You may also want to consider cooperatin=
g
> > > > with the maintainer of the conflicting tree to minimise any particu=
larly
> > > > complex conflicts. =20
> > >=20
> > > These should be identical, if not, something went wrong :(
> >=20
> > Something went wrong :-)
> >=20
> > $ git range-diff b3bb668f3dc6^..b3bb668f3dc6 d6f35446d076^..d6f35446d07=
6
> > 1:  b3bb668f3dc6 ! 1:  d6f35446d076 binder_alloc: add missing mmap_lock=
 calls when using the VMA
> >     @@ Metadata
> >      Author: Liam Howlett <liam.howlett@oracle.com>
> >     =20
> >       ## Commit message ##
> >     -    binder_alloc: add missing mmap_lock calls when using the VMA
> >     +    binder_alloc: Add missing mmap_lock calls when using the VMA
> >     =20
> >     -    Take the mmap_read_lock() when using the VMA in binder_alloc_p=
rint_pages()
> >     -    and when checking for a VMA in binder_alloc_new_buf_locked().
> >     +    Take the mmap_read_lock() when using the VMA in
> >     +    binder_alloc_print_pages() and when checking for a VMA in
> >     +    binder_alloc_new_buf_locked().
> >     =20
> >          It is worth noting binder_alloc_new_buf_locked() drops the VMA=
 read lock
> >     -    after it verifies a VMA exists, but may be taken again deeper =
in the call
> >     -    stack, if necessary.
> >     +    after it verifies a VMA exists, but may be taken again deeper =
in the
> >     +    call stack, if necessary.
> >     =20
> >     -    Link: https://lkml.kernel.org/r/20220810160209.1630707-1-Liam.=
Howlett@oracle.com
> >     -    Fixes: a43cfc87caaf ("android: binder: stop saving a pointer t=
o the VMA")
> >     -    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >     +    Fixes: a43cfc87caaf (android: binder: stop saving a pointer to=
 the VMA)
> >     +    Cc: stable <stable@kernel.org>
> >          Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> >     -    Reported-by: <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmai=
l.com>
> >     -    Acked-by: Carlos Llamas <cmllamas@google.com>
> >     +    Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail=
.com
> >          Tested-by: Ondrej Mosnacek <omosnace@redhat.com>
> >     -    Cc: Minchan Kim <minchan@kernel.org>
> >     -    Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
> >     -    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     -    Cc: Hridya Valsaraju <hridya@google.com>
> >     -    Cc: Joel Fernandes <joel@joelfernandes.org>
> >     -    Cc: Martijn Coenen <maco@android.com>
> >     -    Cc: Suren Baghdasaryan <surenb@google.com>
> >     -    Cc: Todd Kjos <tkjos@android.com>
> >     -    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >     -    Cc: "Arve Hj=F8nnev=E5g" <arve@android.com>
> >     -    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     +    Acked-by: Carlos Llamas <cmllamas@google.com>
> >     +    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >     +    Link: https://lore.kernel.org/r/20220810160209.1630707-1-Liam.=
Howlett@oracle.com
> >     +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     =20
> >       ## drivers/android/binder_alloc.c ##
> >      @@ drivers/android/binder_alloc.c: static struct binder_buffer *bi=
nder_alloc_new_buf_locked(
> >     @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(st=
ruct seq_file *m
> >      -		}
> >      +
> >      +	mmap_read_lock(alloc->vma_vm_mm);
> >     -+	if (binder_alloc_get_vma(alloc) =3D=3D NULL)
> >     ++	if (binder_alloc_get_vma(alloc) =3D=3D NULL) {
> >     ++		mmap_read_unlock(alloc->vma_vm_mm);
> >      +		goto uninitialized;
> >     + 	}
> >      +
> >     ++	mmap_read_unlock(alloc->vma_vm_mm);
> >      +	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> >      +		page =3D &alloc->pages[i];
> >      +		if (!page->page_ptr)
> >     @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(st=
ruct seq_file *m
> >      +			active++;
> >      +		else
> >      +			lru++;
> >     - 	}
> >     ++	}
> >      +
> >      +uninitialized:
> >     -+	mmap_read_unlock(alloc->vma_vm_mm);
> >       	mutex_unlock(&alloc->mutex);
> >       	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
> >       	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high=
);
> >=20
>=20
> Oh wow, ok, I'll go drop my version and assume that Andrew's is the more
> correct one and let it come through his tree.
>=20

b3bb668f3dc6 is the older v1 of the patch [1]. d6f35446d076 from
mm-hotfixes is the correct v2 version [2], although I don't think that's
currently in mm-hotfixes-unstable.  It looks like version 1 is now in
mm-hotfixes-unstable as well.

1: https://lore.kernel.org/linux-mm/20220809160618.1052539-1-Liam.Howlett@o=
racle.com/
2: https://lore.kernel.org/linux-mm/20220810160209.1630707-1-Liam.Howlett@o=
racle.com/

Thanks,
Liam=
