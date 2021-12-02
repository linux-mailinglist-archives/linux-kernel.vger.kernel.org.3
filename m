Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5A46648F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358263AbhLBNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:38:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32561 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358266AbhLBNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638452118; x=1669988118;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KO4e3fWns9FkzQBdUCnCuzvMhVQu2PDWAsRPt9grkw39ZfNjj/tD8ZVH
   o/k91FlfDrKe4UlBOoR2bsNmU3NoFwIzsiPLL6dKVMCzLHOK1B8NLhXtx
   Rp8GRcZyiHeRxhxBoCKiDobyBGckGiiEakUdAEtLwDgYI81FDYsmlKzNC
   h8+dK9JkdlNfdQSaBt9EoNZwN74jRS9syEkgLGgnjw79V4rrRAnO+gG/p
   U/yWa6xgzrNAsHCzuQHJrAzgV/ViaFCxdNxEgV6oC/a7eVwdvpi3kepwU
   sQKGjVI+sTyc7TZRs3mT1bm65NTAuMyzeiBh3+gr0ZjuYS9keS7XSTfz1
   w==;
X-IronPort-AV: E=Sophos;i="5.87,282,1631548800"; 
   d="scan'208";a="186267021"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 21:35:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic/+M8vLMh8YJi7gxHt/pY51oJMsVZpGY8xXLzTQt2CrWNS4S2PaFROBaaG7DxgVNY7UFsg0TPtGmozPfX8uw6/5BTdm1BFYWUadGo7cQ+N+rdmFQAJkYtH1j4nG/u9k9FZ0eSI3idB5wq8ewpd3SMqswgpiekmz1jXsDuRD9a+AKLfCjRkFKF0R95hWY537Wl6d+pfNXkap6W7aFp527kQoZrILm5ZEcrvC7n/VaYKNwiIn7taPGTr1ro1QJ4/g0RnfStRMd4DRrtoFQBPiVH+rdlH+zwcKQxwRdtAXy7vqxRCJGFOzD8bRWBxFXsJ0TLY8rmUUwgmRrdd4Z7WxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ObQxBHnlOfU0sDLRHTyC+7zUdq+UnZuJDZRVEwCUAAyliN5z8VpdwthYHevSOU26wSEv4I7W0LCVEDAzniWyNg9E8kYec/AA9svj5PS7cqxKMgJQS6wDPBdlMEn3ZqJPK7sga9rD9VS+SLpTbjUUSWYGirpVqkVCpJFb+AEU8dg6lP3gvKkyiARDDgNd9YOhJ47buLqOywnw0j3ZshIXY43kpm05vFGzPxgeOFbniEw4c4frFuRRWlPN1zHV90JNk8nKnc6Lq3BB2vIzStEpu+litOF7OWWfQkvFBNL4VJMgivF/+cH0PJOeQeUGSjQrZGl604dGNJGrF7o/MnjtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WMY7k2OfS9KMpf5oi3o9zeCzC04C6FZlOF7iFKv6cT/mt4eu4H0/be9k843iXuePya7FcOBrn+x7sPZNkYBR4NheL4kvxWcp3C/ngpFaSDQAKWOg8aMSbanWPAfb0Miv4QfwwNi7a9uqreZkadpNqGQXkl+90ZAMK0L+1nSgNak=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7413.namprd04.prod.outlook.com (2603:10b6:510:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 13:35:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4755.011; Thu, 2 Dec 2021
 13:35:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Thread-Topic: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Thread-Index: AQHX54FvIcMlx9Z80k2wL1/FeR+Udw==
Date:   Thu, 2 Dec 2021 13:35:14 +0000
Message-ID: <PH0PR04MB74160CE2F8474752F7E41C0B9B699@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3123427-ba75-42be-9be7-08d9b5989252
x-ms-traffictypediagnostic: PH0PR04MB7413:
x-microsoft-antispam-prvs: <PH0PR04MB741327F3FEB315A980B3F0A49B699@PH0PR04MB7413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v53ax2+Pk6qMKb0rtPWebbPkT8soaoPk0pSFT/uZrTBnJYjZ/EDJvMgFdnZZ7jZqVnl/KgwTvwU9yerCNrwrFKuLE6IJ2ZmwULlfdpNmedVHnZbDyUj7c3kxl5XrTWXgGr2+pcrlefv9FW0SQk1/wNOzrW8111Gu/J8y9kG/cRRrTQcod8Hgh6yX0m57O7kqWXuCO6UGhCsb4dk6h3l9UWO3ur+B4iKMqO1FyGUWULlK3QJSMhRt5TLDamOOUTdP+v46uw4ZIyYo2wUKdL+h9ErusthgT+epX/Sm+ko+7xHdc+XGPlQ82XBDJfB+Djcst6Z0QQVRLqgYNYcGwxxAaeykm6/5rVDYyAl60079T1hHXQohkeMkqYmn6eHrW9DW40JDd0XLZwQUyGIiqxCB+1owkDi0X6yYGpquDeNJT3VuTtnyujFIELjLBnIXqJnREu8djxkPsWZUkuNQIdLPkkBm9bhOViHzIqAkAyHGp1n1LMg4q8OzZVljAyNfgXjO0/LNTvFkRXsIjTaF6Wl5WmTYWXNLN3HmGrLL6+hjKL+o8r4pmiE3akmjszW1FdEn4pl4F5e9XOFtlEyx9WB5fT+xiZ1xnFfQHYYDE5sEnuVuOVONunUGztdn+X75NB+52J2ISp2cDcMrDeE5WrVPUjrfng0lPAAAntQqFHzco3Uhq3RqJS1UJKWjsjKWTX982EqMAoWfPU8YYas2JQZ3ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(558084003)(66556008)(52536014)(82960400001)(122000001)(4270600006)(64756008)(6506007)(86362001)(38070700005)(66476007)(91956017)(8676002)(66446008)(4326008)(38100700002)(186003)(55016003)(5660300002)(110136005)(316002)(8936002)(9686003)(26005)(54906003)(508600001)(33656002)(7696005)(19618925003)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UcdnMeVNvTlnortoTZRCM04KoiRNDQi1Syzj88zVXYGGwtM3PhyAL0CTAQh7?=
 =?us-ascii?Q?lzwZFr4vsvxiiSbPoGAHLuKFZU3cjxqVygh6QGOWPGPO3kwydIOOOeoxjgjT?=
 =?us-ascii?Q?4Ztmf7X4I8ybo0mTkNwjkl/atCXjUhoiSiDkz/rM1n4uOjn2IS/JtXYFHwtz?=
 =?us-ascii?Q?A5HEOxw68zGzKs73PR7GWTGb+9J77PePmCrMoh0dJoWxdnqc1TaxBDzXXktz?=
 =?us-ascii?Q?WA+Cjqved/nt3I7WOz2gXYHDLh7a2ZoajStrnoNMr54fIFVcexlEYSZ+ZBG1?=
 =?us-ascii?Q?qa28b2Tvb4pvjE2FOVG8jr3XMKR88L8zHNyRcZasctE673qvvXTVkYcwr/1G?=
 =?us-ascii?Q?EgZUSwWqKnIX2ue8dYNz4QNznpbINk7PPf/cQB+KjUquenvuhE8wrywOtlpB?=
 =?us-ascii?Q?2ELgJfpglnTjlqHxfFJq/0pUlTHzA4tUrlWEH3vRzwfaroEBv7SDoflwYIt2?=
 =?us-ascii?Q?8igM+JO1moS5QAQ6T422WjyTTIb5p+grSJuJGGOKIZg4r0NqVty0eKtsaFXc?=
 =?us-ascii?Q?cf59Q8ErxxUS1XuoOLdydAOetiX4nvX3m3k2Wg44Ti/s3dC4XGtzQitpKW73?=
 =?us-ascii?Q?9D1BPpErWU9mm5NYn14t2BFzfD6eSiIQc2HnlZ/j+o2ik1COyiy1QiXx/P5e?=
 =?us-ascii?Q?lgYSokBMwC684yM+BZlI/kFvazvlriJ5Ya07SpAt/ZuipAG7gngLnzCCWSBX?=
 =?us-ascii?Q?U1yyUBL+wQz6C1Bg43I0UndI2ZkxKpD2VV1395NVw1EywSKQdFSC39osidtN?=
 =?us-ascii?Q?1XDAQ7c+qwgHDReEiO/yXRpXKfwIXNQIP/x+U7jZsbI1qoI8vyL5ZUtkfPwy?=
 =?us-ascii?Q?2MPayGh8A/h0RCtcObz9O16GKPLPgwjsRe7LHilbXMKQrUttgISIxZD2glvg?=
 =?us-ascii?Q?7KWH9U5M2GLRVlTnd7pPMSKizUChU0SraTqClgvi+mX4cIzwOyVkosd1NHeV?=
 =?us-ascii?Q?sT+yNSyJ4o6W4GQPX1pUrMNwGR5Dlld10EUGiZx63s3BiLxf+7yVVxpS0U2r?=
 =?us-ascii?Q?12XkGUaO+JOt4kXD/59UvVIq2i8LP2vtmphY5CmOWAzKm/6OWmuT+JPUmUNg?=
 =?us-ascii?Q?kZggHMbENSirmhW8Y5EXXXc+QUMUiVGeRZU116WdlbtptOX3/jNLm8EN8IhI?=
 =?us-ascii?Q?7Ra1dyqlUx6lIV/BKKwEejwUFx9KsZsSAMk16PBpif2k2IeFMnkYIJUyvm6q?=
 =?us-ascii?Q?brr4KusLNBeVjyNNwU3bfvkrjwPW36SmRCmzMRJ1NEYqxk+O7Fo5DYCcHNQP?=
 =?us-ascii?Q?V2JrUqDv8140fh3pJHPJIfRDpiZQMabG06jf3BfZnrLiNB8XScliYROgryJs?=
 =?us-ascii?Q?Z8ehRfbUAd5aXyzk6uTNp5CjA/xhka9RzcMtLS0Ft+FacineIfhQ8/CaP2vP?=
 =?us-ascii?Q?TAey/2iVwnpkhAnD8oQ0/M7G+uBBkk76Hr5QjccMLQNF7frs6oF6sFclWdIF?=
 =?us-ascii?Q?ELWWFtG8HYpd05DX0iCoO3W7RBLI48Ir1M1VICytJc4kpITxV2FYNBuOItn8?=
 =?us-ascii?Q?BEWm1kL/Yo/jzrR3txsIDrrjzlarJp043RHHgINIco9/YuQ5ZlEMM8Kgz7nP?=
 =?us-ascii?Q?OnjeTRMjKftkIAwpy1N42RKliUoYKOKDlJuBT5or568101vzQZszIj943bPp?=
 =?us-ascii?Q?kvp7/1MaZMS7WB+wpvmPw33mwxG6HzufnFuyVyPPjD3Irxsjv3f3I6nceYbX?=
 =?us-ascii?Q?F8V49jrBL7Ot0HpyO5gZfQeWrl8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3123427-ba75-42be-9be7-08d9b5989252
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 13:35:14.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfFTwqsQJXtRmuUuSeJFzuP5PMQpGdddlesvWJXR0ySeTLvVogWn0r8w2+oZT24UuXpgQ+pYE+dQEsJ1CEHO4nkh4hElMIBITYe52FoLTbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
