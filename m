Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063EE559B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiFXObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:31:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DA562CB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:31:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODhubi018576;
        Fri, 24 Jun 2022 14:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FYkyrXvZCkUUtCrFWcoTy2Kt7GcD4QfRogy9L4pTCr4=;
 b=OV80j/sp/ZdmPHDD+/OjFKnm1e4Tlk2di7glG/St9s3tJQVyNW0vBuDCGD3sRoUL9MGD
 HO/EbbswTt/n87lhQQEAsmEWOhn/c9TgW2EAOzc8lE2Aj6gadE3vn8OvvjYQb67g/WwQ
 Q+gw7wHybPpmXE5CWwu+sdRh1C+CYYyFrfZnbAEn0OycVxrdzsAPrr+MsGz0R/UZmklR
 VrsbHEk8hTqG0waCTzTLFi77h1078kRgkAchc8eVTbygrpQMb3/Rjm6MlUUia9h88GG4
 CkAYsEZDpX8WcLSYw5OAFtoRuJBm/DTIxOboXEJ5pQtZVgvNTXHSEAqPRwt54g9axi5o ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g263qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:31:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEGdCK030369;
        Fri, 24 Jun 2022 14:31:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth90jq36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXRiQ06mx5JDUT4XPdOKq20Hc+BxIElefTu39gbmZofsO0HY4RXDdxdjvcnFRQiga8cXUxLwhk2Li11S8kukZaerH2Gg/z5Coy/tkNj+BGgQhgoKrhIaCu8Locl65MjPmPsp7fofwxPI55CVAmk+aQ2ojTr30offjR5TpwNhX0qfNhynOhykNrvLcT04t7rCdqCqSh6UwhDi6lYYccluOJBVkGHXgFcqPGZvz4xlbjnFRKMdINjKkQjp1aw3Kf6HfSCVtOHCOTQLTRDBGTd3M/EbIjXpHSspHOgnWgeyRkFfEq28okcjkmz/Isgtv84JhxqEipwbPtaiwGNrxsI42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYkyrXvZCkUUtCrFWcoTy2Kt7GcD4QfRogy9L4pTCr4=;
 b=adg46YqTNoaXmNE9kOFO/J17b7ScWusk5V7QMLfKs8e3j08gzA94LPkja8Chwpwl6XQzeA8hEz63pafBj47ciqBJtguxVqy3cKlfERTMK5zJF4T1TeRHgnQV/X9tDfIWUvF5nqYQMv7LRqf2+oVb21uZxRyWeWV+XzKhrIoHzUqb70RTKRVXktGPwz9/FYil/Ic/dXy3CecFfiMcXMGCUrgy/evWMB+xbsyvXmPQIL1la3YAJ0O1jBsFOzZZ5eiVD5CxE7P0Fdvf/1K/TCLJEKwnJhazi6swd+M+z1id68E6YTVCcTzpnA4YzWbcGhK3iCnYe4t3gJU4yp93QJyN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYkyrXvZCkUUtCrFWcoTy2Kt7GcD4QfRogy9L4pTCr4=;
 b=mNhXC5rT+bjGej5sSclcT9GnL1HEE6MMNFxWcMsfJefzCwoVWmOIFNb6lBBz2Tm2z2ZUbcgtdk3M0q70OTbBSa7IKoN8Ncban7BXSo8lnFR/9G5hy2bdm3zAH62D4oRdPwW9Jqc8ogoL7igjMx9LElMhPB81LXGPsH+kYnwLFnM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3107.namprd10.prod.outlook.com (2603:10b6:408:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:31:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 14:31:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 09/69] mm: add VMA iterator
Thread-Topic: [PATCH v10 09/69] mm: add VMA iterator
Thread-Index: AQHYhbAKusyJX2O8zEyolQwi+YlQ8q1aWzOAgALfoICAAWftgA==
Date:   Fri, 24 Jun 2022 14:31:22 +0000
Message-ID: <20220624141655.zcyebflytmftojsd@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-10-Liam.Howlett@oracle.com>
 <20192b57-30de-1426-6694-238e018104eb@redhat.com>
 <YrScxyQ5RRYYZFrj@casper.infradead.org>
In-Reply-To: <YrScxyQ5RRYYZFrj@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cea0bfa-ccf1-4470-ed6a-08da55ee362b
x-ms-traffictypediagnostic: BN8PR10MB3107:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jgvw40ESeDCKveagX16jmR9f1/j++BF+GutWsZzl3R7c+IHkpvOALlRKj6cftXNxo+WornLLWVVP78LZKZeWwvALoxrtDyFA8XaKL7DiT11Mb75GQW8gnZ1t0jgON//FI3PQfsr5Opebt0bdGJlBnUnAucQpquLhG70XHDbeAuOANjSv1sKkFKKMCkowl1RJkZcVrx8+a5lZdAPbQHX/TwKHMDHdlaCeEdk5NMoh7lgcarL1qPu7AMu+2HQ8skvqIB9TQqCYRNCu6299jhHY7LJDa9YsQizCEoLuzWmlrdhisHkfJKenTdUXX50HbmUtL8CBA7UXmfVxnmrTeLDIk/RRf8+LfJakrDDqxOI+SqH2gx/cjXI1OD4YTKT2wtomDkbqFO1lMZ2ZDufylnP+XnScT3SWdbQUbEtitk+P8ErxwWMsRvFbn+KeOYQW91e30uEs04+jHeq1ykvGeJjVMv45vCfrdESa24axXFXSMaIGzCRA8G/yn7v+nMX5dqx24+A+4rn/RLvm+QzeAnzIdbOMJa5iqQnx9VWG1+VTmeQhScv7uv8+pVH278mXB4V2UyNiGG1WqTC9YAvshMZXg4/9TKt/KMesPp4EcsLRsNsL38o4wyHy3heoptfM9CnCCf8zLw20+DfhppVK9mG4NJW+BKJreNH1swqXDzwEOtB3vQiVH+FArKnn/Q+Kzt97GUiVPBagoiU7NQ8eM2hh1f1Tepih0yeV2P4k+lUesn3h5SOvIRoxUu3WjTyuEE6MfKVSMeIESHm1EBP302KOZ6w5BY6Vh/P+vj3p2Aeh4XY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(9686003)(6506007)(6512007)(186003)(5660300002)(26005)(2906002)(1076003)(6486002)(71200400001)(66476007)(6916009)(91956017)(4326008)(316002)(64756008)(41300700001)(8676002)(54906003)(66446008)(8936002)(3716004)(44832011)(66556008)(76116006)(66946007)(33716001)(38100700002)(38070700005)(478600001)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zw4qK3AqAOvIsvfk+r7ixfYhN4e124ucE+uijo9Jx8518jHladfifCgrQ3dE?=
 =?us-ascii?Q?PeYRD/w7dVBa1/Ml4RmfN9iiNTSxLRgJqR5Gwg6pIbNl1O3Jif+MFfW702l4?=
 =?us-ascii?Q?t8wkjx0H0GOom7waFFQN0tWpBOm+z5B6WnvtNAEtv9q8EcIAvfQcS43CS8CI?=
 =?us-ascii?Q?0nsnnkX3QnkKn5GlBOJt0RZYZBdGkRsx8lsvdJegcJSW3oolIEp7FsK8SLn7?=
 =?us-ascii?Q?UsjoxnuQV4Wzlv2nqIgbXQyR4BfgVqrbWrV3vhhEeme9asVmY4gWnADRH2w4?=
 =?us-ascii?Q?PWms3IpSwpUgV8Zr/Vnx+5wPWdqsUZOUBlXt5pB3UGTqRUqXK5q6aEwpsRtw?=
 =?us-ascii?Q?DFjpJtikjeXfw1IRjbu0Kfnl+bRqXHW6i4L/lLInu6GEE0RLAR4ZJd/OflNJ?=
 =?us-ascii?Q?Las4wG00kEtE0MO6erDMvXEbt5TzcaMVys/UVTpj6Z/qBvQWpih2qoQTnQfF?=
 =?us-ascii?Q?/sqlxaZ/3lSMiPHxkLEqfY7KKM8qPYTy8z2ysPLkpyMm864yMNjWzMpYdSZM?=
 =?us-ascii?Q?AzkxlzkOXh0IQqCR2JViwI+AwWZz4Kxm3FNkLISukSPd/PYoRYoSx1POyvPI?=
 =?us-ascii?Q?eZsA/P6hNVYbYG1b2dnpX3MTLKsZVMR5sQPgJr20o7EAu9yJ58IKXnUVoMQt?=
 =?us-ascii?Q?ws9seyT1BZq57p/QqZOklB0u4mbCuEd9f8WSRSrSqTQMqCUNQrxg9nyE5Nut?=
 =?us-ascii?Q?pmAZqWw5wsEmMu8cJumvYccLfXEnoBOLNAKOlyfDfcOhrBYvP9sYDb2Skk8K?=
 =?us-ascii?Q?s4cp/bDhf+4152V/lr7OYX2+kWAIvWgcdgpByvJeIiLnySqpZ5PMrBfPN83Q?=
 =?us-ascii?Q?o9/e/3fJNquBkE66uMm10PoIQOtm9NgCNy6yt/aKZRLWzplPn47PrVCVo9fS?=
 =?us-ascii?Q?V5OfNI6hOd+zeSAyMnrXpJ9MpqKF7eHeOswsmXmLwtHEDSLcU6SikTGWyenI?=
 =?us-ascii?Q?Y/+6nNSPT/Y9DG0PLJ73Ty8fKIqL8b6eBO+YRCZT/GCskj65zaVIlI/db2nd?=
 =?us-ascii?Q?iBBQHZlf40xRIP/SeaEkscD5ihOeR7hD3DNZ49QfWZ2t6liBHpEHPHuc1Kdc?=
 =?us-ascii?Q?x/WlF/9Fq37Or3GW0+sF65BNTYD7KAnVWD3GoV+vF0fTCP50ScFSlmRVYtd6?=
 =?us-ascii?Q?J0DlAHOV+IgFCgYb8LQWmWXQwEUS8IX5cR1i00EL8nUC/fq4+0G+5Cf/Bbs5?=
 =?us-ascii?Q?Jmx9/U3geUTNg+5AmxLczlEERLCP9tcbNmikMgGoXp8py7LzvhB93ONFkyeg?=
 =?us-ascii?Q?r5JFyb2b5nTPfdPE17jx3YB+yY6GhVjTKMdhugim6gyEwh1yk0KoCAuKPfEX?=
 =?us-ascii?Q?atCvJhfGGa3HKKrFh0PQZczG7AXGYmYYamJg4UA7wNsqlLrn8U2hO6025dMs?=
 =?us-ascii?Q?aQS61eqdzUTr1ueBFiSRI5iYnbGlIu+fAOB56YXn7bqoO8UejYCUDsGprlDd?=
 =?us-ascii?Q?DfNqFJ83z/o3aimShN4Z55bmFstlHC5mxSf5GnuGesNrFOB7LXMc5z6tz3Xl?=
 =?us-ascii?Q?vfbNFV25h0UPluQCNrHfNa/LSYYGsBRiJa//M92O7MKPaL3u4J5GRNW0ilAz?=
 =?us-ascii?Q?ont4r7Ysk7ePs5rcc9EcaTW4P7BepMvVm0ns0l82js0zs4RNZv8b63+p4Mo3?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E8EDAF540AFD34791C24BA831E94333@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cea0bfa-ccf1-4470-ed6a-08da55ee362b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:31:22.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oH2Gf8a2Tu/pHvPj76YUgcrDmMFlc/FOJUnGRrYNtFxkQJ9SHKHYr9xtKPOBt0lhSamHKarzIwvjR8Aw9OhJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3107
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=589 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240056
X-Proofpoint-GUID: -7f6ZS_e1cqc0kym1wBcmoZWk9acaONg
X-Proofpoint-ORIG-GUID: -7f6ZS_e1cqc0kym1wBcmoZWk9acaONg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [220623 13:03]:
> On Tue, Jun 21, 2022 at 11:10:09PM +0200, David Hildenbrand wrote:
> > > +#define VMA_ITERATOR(name, mm, addr) 					\
> > > +	struct vma_iterator name =3D {					\
> > > +		.mas =3D {						\
> > > +			.tree =3D &mm->mm_mt,				\
> > > +			.index =3D addr,					\
> > > +			.node =3D MAS_START,				\
> > > +		},							\
> > > +	}
> > > +
> >=20
> > No __* and () macro magic?
> >=20
> > I'd have expected at least
> >=20
> > tree =3D &(__mm)->mm_mt,
> > .index =3D (__addr),
> >=20
> > ;)
>=20
> Fair, fair.  Just testing that change now.  I always forget to do those
> things until they bite me.
>=20
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
> Appreciate the review!


I'll also do the same underscores for the maple tree defines where
necessary.

Thanks David.

>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index acbd8d03e01e..8bcbffefdc02 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -686,11 +686,11 @@ struct vma_iterator {
>  	struct ma_state mas;
>  };
> =20
> -#define VMA_ITERATOR(name, mm, addr) 					\
> +#define VMA_ITERATOR(name, _mm, _addr)	 				\
>  	struct vma_iterator name =3D {					\
>  		.mas =3D {						\
> -			.tree =3D &mm->mm_mt,				\
> -			.index =3D addr,					\
> +			.tree =3D &(_mm)->mm_mt,				\
> +			.index =3D (_addr),				\
>  			.node =3D MAS_START,				\
>  		},							\
>  	}=
