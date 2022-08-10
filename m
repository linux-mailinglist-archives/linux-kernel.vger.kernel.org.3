Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E158E4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiHJCFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHJCFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:05:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0639F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:05:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A0EKGA027263;
        Wed, 10 Aug 2022 02:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5ADo1VarOD4GB2tDH3bOTqhpLqBuFOOhiSQtFXDRL6M=;
 b=VVBWW1+eKNd1Yo5LdrhYaUPliWTUpwS5LT6hIzmQTFj0xEXc9Pl4phV7Q3iv3KJzoSSC
 GXGBnALj6q5jNjw0FMgQkizyjkxFjk/Q93f8k34Xxh6D1SoXp0QR1g2XZ4h0H/zotcde
 Ud3gP/HpnpAII1LU+Mp0ZXnE+zjsy1K7VqMgkPewvF8CQV3WdxQz1YN+oFMo/HMub5Ec
 +qhZZ5GQuPro2hVyR01IgLHcTjyiyl2zfLtZ+2uPsQiilacXa0gYTfyE+LU9pvDjQXmx
 IA28qTfoJSKUVDJLaOEOwnjI45/nf43AtCyKY3S2cL8OdSjxzrw6oDvpyrkkLUWGQj7N 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq90m76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 02:04:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279NaCoE005289;
        Wed, 10 Aug 2022 02:04:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhqhd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 02:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANuQCLNibI2SljP5k3R82aeHU+OdI2P2nRpDgHWHki0HMS77qR3ZRsjVHdUBnK4NVJyEKaSk8KdtuLntp+cFefUazZLarT/Ftch3lEq3SLvDU1vmkQ2v+sMmFUy/iOPAc/u3TffNtkOKCyknKCOkddq6Q26YnrTn4oIPLzWUEqk1khhyJOJuSKq73WMfjxnPDS14Qyz4ARTMoOCDIlBY8RGNekyin5IKFCVZCy2R89VSfcTE0qMlMtz/4TeNGU29/DWz/FiRFbRmp56SrfX2l2BthPntnnOPAmmS45ycGMBmluJ6lUyOKlV+HSYudhdW2e9n6xEYd3nVutFtv95Ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ADo1VarOD4GB2tDH3bOTqhpLqBuFOOhiSQtFXDRL6M=;
 b=TYRr6c3zc6gSvYsmsaxcf74hl/rzuIz8PV3zUV43e9E1CNX5CZ+pjETVqn6x9SDEAL3NTXPZ5Zvvol8u8kwjhEOqM2Ke2IwQa7z9KIhdNOaoYn1j6tIfbYW0kMsB+JiTbtB/51+0wZ+z2o36n8AyimOOJ01jo+0jngzRVo3+jUD4e+aYFvn4BMAiwwb4kUeIcgyx2oeup+SmfDN66cOYtAXA834JlXEsuORYUCtol26C92abaxJxCOGCN2mQyJfjcg86yN0ym0+BWMpry6kWtBkZzerWTS1nmTtPdm7lP0cjtOQ+p8UT3fjgj79nNMiLhbtWRH0CqQSYhHkk9bB5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ADo1VarOD4GB2tDH3bOTqhpLqBuFOOhiSQtFXDRL6M=;
 b=VPI4XsxqjOhMWOiQd9RxC2RUEI/GuSe/onEg76PwtzBPusXrpfpYWhATdp7QNUqegnZqmacklQu402vYvw/TnrXNv/QRFkWPauRw/GCekSnJghtlUc23HMrR9LXkwgMuIsoIkD9FE/er+ksl4SO125RE9xiX66WrdjPgiNJbet8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1362.namprd10.prod.outlook.com (2603:10b6:404:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 02:04:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 02:04:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Topic: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Index: AQHYrAn9C2tDT6s3j06giZb3JwoEAa2m6VSAgAADp4CAACF0gIAAVJqA
Date:   Wed, 10 Aug 2022 02:04:45 +0000
Message-ID: <20220810020435.z5glrn3juva3r4pt@revolver>
References: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
 <YvKsI5pMbgQ5Irup@google.com> <20220809190211.ew4taam2lcomramw@revolver>
 <YvLLQ/qasEJffdnn@google.com>
In-Reply-To: <YvLLQ/qasEJffdnn@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef87ed80-46c0-40f9-683a-08da7a74b2a5
x-ms-traffictypediagnostic: BN6PR10MB1362:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3NVCfgucVZ/IuTrHG9CE9sfAjyC8LU3/I3QPVnTe6wTBU7qPSuDthwowdXr+xQj7dQSEQTqZiAr9khoJKa+rCKfD/zPQgAn60LhWNOhuhlMl0BiNvrGr3O6h7RgBCi13461ZUI5r9v4BGom/BxkyqUNgUBEE8IBkcfJu3SAiUWjOjET+v8lkDE51I+ERpyIVipckvM8dc4Br+kqaPjB0gMjHS93y/nS2VyEQI32QdcQUEtGRdflJt9p6JPwyDL7QHqYh4W7nnxORfSBQlAapJDm8pfhIvqq5LCVgyomBKc6zr/yLpMYIfWPQxWeixz+T04WNaAdp6B2Ix51m5yIhbMM6MljKtdEd63C77oMnN5tB3DLYyykhj4NhVGmd8RryzhL+kimwe+G6RbH914I/JCBKX9BlOGEwVoGy93nkvHnumjIs3oJlNO+glWx3ot8AkaalIHzUKVSJ2h/RC5Sj6eTFiAD8CX7ncPZH5ZNW9mzbF07YxpQicgWifyQmP9QAIT/NavRmWanzB3mltpBxTtrAkLlSGsT3g4hb9Xlj+fmD6yfTyZxbMIyacDOP8zdoeiZD+3NXkXj71p3Odzuk2dm8jVVsxO3IJOxTvdVIeiYUSX7oDhb7ASNnViGVhdl/5oH3f7HX/YDiC64+if2x3DRXdzhYZEnc7f+1fYhbfnqYOznzZ06G39nCly9ga7laHXiFTHkLlBWsF5lT1J0M1NNjeqBTHJBncYX+Nw2Evj/gp/ntKGuFzI+OzX0RquF+kV5fS2vcAcUD/AFHiatsx+YhOqISC2h77V4c9JaW58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(4326008)(66446008)(8676002)(66476007)(66556008)(91956017)(66946007)(6916009)(76116006)(54906003)(5660300002)(1076003)(86362001)(64756008)(38100700002)(83380400001)(186003)(316002)(71200400001)(8936002)(478600001)(6486002)(26005)(2906002)(38070700005)(9686003)(6512007)(6506007)(122000001)(44832011)(41300700001)(7416002)(33716001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JoZwQzhAAiyZXn+GWa1dL2HIxvih6g8cdpAD+MY4WYH2cYnuy+IPfAJciO?=
 =?iso-8859-1?Q?3jabEeTZCN1lcPZNI0dSX7YtMR0yxkWqraxntncovX5UjesiuZHWQcNU9V?=
 =?iso-8859-1?Q?ClDeIK97KDU5lBVEbgz4alH2ai1B8Kl2WP4GNyRmGqq33aSGdW7hkurOPB?=
 =?iso-8859-1?Q?jfpUuP4r86LX5AqoB35nXAbfATaES9E4FSFDxQoTNM8d/icGdiRURoHM8t?=
 =?iso-8859-1?Q?0xrrhCjUGTT7UdWm4cvEUQRZHfl6+poxzSW3z9HjQDqNYnbau9JCQIgUG1?=
 =?iso-8859-1?Q?CPaUId4Rj1aThSuJTv0DPK0C9w17oXZgtk2aktCdU0rovllGgqvQ1A+2pm?=
 =?iso-8859-1?Q?YspUXRiQXXLifazwhPjs7vIRM3mS0qIVqVzCHN+Ta8+hDahoAZn8vpOqCG?=
 =?iso-8859-1?Q?H1qaWlPLBKDwi0Gxz9GPa/FyreqLrSaBU74EMoV1N0OoLhmtp6cf4iM1vt?=
 =?iso-8859-1?Q?elu+6VE6I/21eixrgjhosyURNlSumhT54DL2ZI7/ZqaeJfH1wnTsjbF2gc?=
 =?iso-8859-1?Q?WWzN9FXWLaDw7pgS8w6okUvKLUcR4L+2/JYswEyMD+Z3Ugj6NhzPTEibUR?=
 =?iso-8859-1?Q?J7IBmk6JHiVj68FebQM+JtxbagshQ0zfwR+09ws6Y77WYPxegznU37FGX+?=
 =?iso-8859-1?Q?yqQGbEYreA2s+JX5J0suH7UDbb2nBr9ZwbU5Jvetv8Xod8hHnoW+2TS232?=
 =?iso-8859-1?Q?5O244UWIFxAnIcG6kjy3/kLn/ZxiS1/qBrAey3lswfFjWy8sTmYMdwc5iu?=
 =?iso-8859-1?Q?lL9+2WmhdOks8SO7lWjJeMEgpI9Jf37xVieyvPxjkoLk+2FwjzeGN67hQj?=
 =?iso-8859-1?Q?wkGzR4PPhLF5JgaWxRU6qlba3jQTbbAPAkaSeLsrVHzwNIRcc3w8X+3QSr?=
 =?iso-8859-1?Q?W/muQbH6lgUqGsc5OLA89pl3kJ/aJTfOY1XHYrTcoL76iGZ+8cONOkVHeK?=
 =?iso-8859-1?Q?0nBD03t8w8bYBg0EhIl5Pq2y4q+VSq3J/GVb1bVCHqBkpA+RwlqbkJN8jb?=
 =?iso-8859-1?Q?d5TZUsEH0UMWfABLgKn4BLWfQWbpCqWkvILdECUkh7TxDXdqgB8rQnH6/3?=
 =?iso-8859-1?Q?JYYmneWyg0/3Fw0QijT5Iz6zd6u+4S1c9tsjnnpmmEUt4350xwz6qCj2V3?=
 =?iso-8859-1?Q?hDHM+3uLR+tePKApGf2BHCrvcTFpSvRyoCrPkDJZBlZN/gYlr3StpQhjfm?=
 =?iso-8859-1?Q?Noy00TFu9ZmhK35IRpNkPEqYat+PQU1SU18g1+OYNbVybY+SIWu7UajjBc?=
 =?iso-8859-1?Q?Qtl5zHqJggm656s4LaaiD98wuVbxo3g6BMmD5kFoXHIHS76G1YJr3b59KD?=
 =?iso-8859-1?Q?a++ppOPnr1SlFm72BR1pzU+eb45QCIzToxAF8X474Fr3SnUJsNv7ohEktZ?=
 =?iso-8859-1?Q?lRqmhD1lMxWryJ/Wei0k3BVC+QguYwjUqGWOW6z1YhZ20AXKhfAWB+2dHJ?=
 =?iso-8859-1?Q?og4/ZdNcLxRJpFjTK6FepTvcEyGmADteQ68ka47blBESJM5ncIkanrmhYt?=
 =?iso-8859-1?Q?E+Y3wwZVYsQEECmhJq6PMdBwCzN7tP0TVtO6q3fuCZYB3u4bnHz7cGIcUa?=
 =?iso-8859-1?Q?QRn+Ysc8NbPbgOcO0wfyKAd7tf1IFqc3EOUFSYK3RRA7QOy2E0/vuACpUr?=
 =?iso-8859-1?Q?RIOGioFsZfc7niNAURZTfRydIKbb1ct/yOTfG7082raEhOM+21GP7y1A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A910291D46479346A0C4157A7C26723B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?Sr27z7glv1nAq6IkBUuc1xXV4FQu6ZXVJr+ZAVvx+J+p43x1R2rMR23Nyx?=
 =?iso-8859-1?Q?/E7oUsrvrZZKbtFUwk9OvcypAyNiJ7wA5Ur2cRcW57EEX5vSuA2HNpDalN?=
 =?iso-8859-1?Q?CoIDbaU36xe/oeVgkPYEUKj6U7tgTNw+Go7W8t9wIaR6hI3QRXHj18hhn8?=
 =?iso-8859-1?Q?7mD039g5b8RjUvtfTb5Jct0ZtuZQ2qDCu2L9eKb2sMhwqHkxjYr800Tms0?=
 =?iso-8859-1?Q?E/Ntd1kaz0KfgcQswZEylzhTRhDk134tCGBZDww1b7SP3r7UZ2ys1P+I3H?=
 =?iso-8859-1?Q?1RGP1kxgEAo7of0PvP0Om0q9yy1Tu1HxCe9LPpsG+Gv6V0/IHo6RIWV6pb?=
 =?iso-8859-1?Q?tcbQge2dlvD1xOemAfNjdJjmDjhW7oyWbHxtrOdQyemfXPBtl2kW9V2V+z?=
 =?iso-8859-1?Q?pDJsOka+8z0CmBBu2x4q8uNTlv5v7KitI0uGVQYY8e0Liamvzc4wIEsyrq?=
 =?iso-8859-1?Q?uHhfXPgWyMCCt6Yph4AVl2UFkw3FEj/d1aTuEMtoE4Tuhj7GTm/8azkGf+?=
 =?iso-8859-1?Q?zljMYpWvne+Hri65OCXKHbEYZx0msSlZzOg6t+RwHzkd7pJ5o1u5M8oFiC?=
 =?iso-8859-1?Q?gDp++3wGorWS2BpXI0TH4ykZpsp+QgcXTEu8c1K03jVvgkxHE8yCPUkDGn?=
 =?iso-8859-1?Q?fCQZKGVPJEZ3g0J3haieLbMkyAafpSIxJDiO2bzwA+Ec2IJ+fT01qLsH7v?=
 =?iso-8859-1?Q?ICIDSvePiH+VVovNqPmGp6JHQox2JwbOtqtj3AeQPue4OVDxajsJhI9Aio?=
 =?iso-8859-1?Q?3dFIoKm8SYnwPgSPgA0X2IkU36KhNhfMVJ3BEnixFMi8n82twX59i7GXK8?=
 =?iso-8859-1?Q?QfohEaRuZJ6F+aR2rkFaamC3FxTnJquKd8RYOSmhiF/ek2h+liNAfJ4m0L?=
 =?iso-8859-1?Q?j3W/YWzmG3JXs3dhq57KyqXzQ/9Fg/0IEM63/IXomqB6Z8CDqSS7TOy+7N?=
 =?iso-8859-1?Q?0aFugB0yd2LfOCFfkcZjbZtY7pGWVEGNqmEJfJZT8Oyh9M8/Z4hgpgUii3?=
 =?iso-8859-1?Q?7nTjsJZf9O1fwAUu0NX7bMm5WrVrBqeU+1v+73WoqfWzCL17dG6kdccb1N?=
 =?iso-8859-1?Q?0WAsvvxvuvoGbKaM2bYI/gdQY89LpOAdXVG1jN3aAEwRSFUbIUu3upZilH?=
 =?iso-8859-1?Q?e4ROyNHgowf5lz27vVzHSoFv9evqT2gC2lgumydcEhOhzjZXR7KUmSPh93?=
 =?iso-8859-1?Q?lkRyNkSb9tPN3oFyxXe3Y3ZKdKMArlEUiaLaircH1i0KVksRhUkbfgNxFU?=
 =?iso-8859-1?Q?IzEVIkdegi3Hz1yo6/QUEzI7KkencS8jbfBRTOhUHeSq89bteYrOaIbR31?=
 =?iso-8859-1?Q?JZpJzszPUpI3v0AcctorVIjBzM0BbtIirsY2Ld5bMp84ag6AnztjuQ38Tk?=
 =?iso-8859-1?Q?abHL4DHiZFvHGpQzSUo61+2JTLygeMUKbzXkHNRpVPJbVFMyh6rwlnhBXR?=
 =?iso-8859-1?Q?HtvBL4DV+IlM45DFVbgOldgfq6rdfm14A9LnqPz0LQmmd5bBAkfTZZqKuU?=
 =?iso-8859-1?Q?7hMLfofyloqGt0r0O+xKaJumB0Q5SMilEqSFYqo+EqTfBEEImSkmJTqJTg?=
 =?iso-8859-1?Q?3OLHp9QjA2BAFlTzJ3FPN5AdCR9bZWebWbKGnSO8T5XBuytM5ldzVxJ9gb?=
 =?iso-8859-1?Q?5/QD5BQluRQtjOen8lDq7B48uCRIACDYf6Rkc027V0pwGas8dQ0mRukDHS?=
 =?iso-8859-1?Q?KK+/sGn39wq2ofIMQ7XncK9xMqRfJs9g+PRupNxca5m1f3PJ/nyheX3Ok1?=
 =?iso-8859-1?Q?ilkJ8FdK465fJH/8Q0PRDci0N9UYwmUROzl1LSKtFYZWuz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef87ed80-46c0-40f9-683a-08da7a74b2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 02:04:45.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATZUcJPMsSbaucgq8EuHufV0jwc7HY42aEAz3WlZtyJCZQa6l6r3TlDQv40PmCtBvZSkOYtGNfKWQXMsM7a2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=854 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100006
X-Proofpoint-GUID: nmA_U94TU-PuV4eEAOVn9WPiboaH5tHc
X-Proofpoint-ORIG-GUID: nmA_U94TU-PuV4eEAOVn9WPiboaH5tHc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [220809 17:02]:
> On Tue, Aug 09, 2022 at 07:02:17PM +0000, Liam Howlett wrote:
> > >=20
> > > do we need to hold on to the lock while we loop through the pages her=
e?
> >=20
> > I think we do?  Holding this lock will ensure the pages don't go away, =
I
> > believe (looking at mm/rmap.c comments on locking at the top)?
> >=20
> > In any case, this function is called from print_binder_proc_stats()
> > which looks to be a debugfs/debugging call so I thought safer would be
> > better than faster and with a potential race.
>=20
> The pages are protected by alloc->mutex, so you could immediately
> release the mmap lock after binder_alloc_get_vma() call. I agree this
> is a debugging call so it would be nice to reduce contention.

Oh, I see.  The reuse of page confused me here.  Yes, you are correct.

I can re-spin this patch.

Thanks,
Liam=
