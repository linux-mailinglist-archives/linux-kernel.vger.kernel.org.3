Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2A54EF38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379726AbiFQCUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379662AbiFQCUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:20:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB064BC3;
        Thu, 16 Jun 2022 19:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCOGe50n1MC+wo35QwadVZXvYFiET+xqkp2Ba/AY+tzYAM8arpKTBRrLNNE3cV2vlC4ZJjqZ8Kn1gr0M4m4UASaDTucUgoMPig7Xt74z/CU23Oz2HL9urMwVJCyLULJOGtB9kTt77E58GE7ppZ/sWlFEh94stePnia4q3i185Q7JJl4Ob7dVLQkiQtJ2OFN0QAvKytkXgetN5b/eWWRDcCBSJG/M/BV8C8NZweFX2YXCOruh9Duquclb2VT4tSLt9f4lHafTgY/SNbUJ9W5BR67EAuAcaSgMQwiLeJODsSo7xzfVNYTVZBU5nIZQfDz/9Goth0MvFU7v8Jv+3HC+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foNXHRy/Q+mMhXtE+2H3C8vpLthVM8mmLJKBgfz6pAk=;
 b=JQVFprHnrqzfFPGDhOuqaISr2vNXQK6ECFgfuCj9ZgV/JMNMOo9LzLoyGqZ72KG1AjW6RT/VPjTkuVc7aqVC5wSIATZVHcUyuEOtTbJcoB7UxaBBqikee5eLi+8gcUA9ggYHAWUEsOKVl/6zDZ9vXl4ifvn+ZUwM2N4H82x7hUiGoKH484gVKtWq10lXfQTlTEg4Uahi5vptx6vBEPGqTcaVZIBvERWcFhbddx1z/4wtDGGIHB5EZgSlRIYKIw73c8GlxsjvOXKk2PgCZv3Ddd3HjgIfcvDfSlA7Jh8VBLvC3R65tR47biKWQHY86lxLpkYZrqcPfaYVPbsCpqyK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foNXHRy/Q+mMhXtE+2H3C8vpLthVM8mmLJKBgfz6pAk=;
 b=rvYDBQb31BbxZ0Mpbt6HH7XQpnJrScmwyUpxHf7hvv31efVepODFZLnlMmtpi644YCtucWgGi8VOvMOVsZPjUskL+PeZ6I2DzoD5Zqh8tGolSphzXd0kZasnlDp0RF2jbZDFrgL7Hm1yTJursLjwnYL5POMuRj9AMLt9yxgBQ9EYkFOPU4bvepAmWeL+kk9wEXEN0x9Nxhfqeti7Jpdhaq7PBgD49ey3w8nsAOe8DN6BQ5uaWFC4veXYQx5quUG5FPGBEkXXRc+IHKuqo396QGMfFdw46v3ZupyZlLqOBjtVQzb7kvth/1LokHvw8+pmeX/pDEV0TCQ1RsDSdMEVYg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3764.apcprd06.prod.outlook.com (2603:1096:203:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 02:20:44 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 02:20:44 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Zheng Bin <zhengbin13@huawei.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gaochao49@huawei.com" <gaochao49@huawei.com>
Subject: RE: [PATCH -next] usb: gadget: aspeed_udc: fix missing
 spin_unlock_irqrestore in ast_udc_ep_queue
Thread-Topic: [PATCH -next] usb: gadget: aspeed_udc: fix missing
 spin_unlock_irqrestore in ast_udc_ep_queue
Thread-Index: AQHYgYQVw74ia/ux5UGHL+s/JxFveq1S3kQg
Date:   Fri, 17 Jun 2022 02:20:44 +0000
Message-ID: <HK0PR06MB3202958ED74CD706458B85CE80AF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220616133508.3655864-1-zhengbin13@huawei.com>
In-Reply-To: <20220616133508.3655864-1-zhengbin13@huawei.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d90649-6636-42e8-3162-08da5007fb8e
x-ms-traffictypediagnostic: HK0PR06MB3764:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3764FD4ECE0855A91F784E5C80AF9@HK0PR06MB3764.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rl3IBuL+QfWQ4IQPOTkOrWbNN9YpkLT6Kp1i4BpDwR9aQFThkVVJUIQ/LNOnQ6Z+i4SVt0jTxBZDB1k0Dc9pWrfVylURnQQ5ZADM9DqX/V+YePsJ/29rthwZIK18XIgDV6JcmHCz1vZnyTdqlyNBhZiLvsvR4Dl1qEAztDMdiO4hRJQ6zJypOFq0IvDBXjo08A4gPDOT9eqhw1M5QdY7N2PZh6033nTuwc2E/5/HoVi4UjlJ+FlJABcldKEBl6D2OBhzgusSD2d5q8a+kgNyTqp9iEb53GrsKc1gJcxx1H5gkpTCWYda221evlONsqpR/h139QlT8iLON+Wuh8mhxussRDhS40wfLLBO8I94vvXOBcHMIt+Lia797O0vwLNBr+4nsPbHtMd7atHfwR1R0gW1toGfzTZkv3zQdzBzxPZsSaqm3U8yYEPymelHCIOYji62fNyICBLBDVJ3LHkx2KR6356fS0sl0bdW1s2e4QlKp64IUsW+kdW0O8vl1UDz1WeVjQZRq6of2zjYfLv6m1flpquTOGI7QWFxMeUqDq5G9UjZ6CEiqlhH9ShPhNKllCcm1D3OUrtJZUiMMqhzEL6rcO7nMNjwfcy+cnl4Hfv91oIhvpgEW2Lkp7DkyWiI1tOwd465VjpF89B4xzP5QwFbTEVE7KnkC0UiKIeuIs7hQpGxXoyBmq8/WuFPKcCdIABvtM5lExdmNr1iAx9stg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39850400004)(366004)(38100700002)(316002)(186003)(110136005)(5660300002)(55016003)(33656002)(122000001)(41300700001)(2906002)(6506007)(7696005)(66446008)(66946007)(66476007)(64756008)(66556008)(8676002)(4326008)(38070700005)(4744005)(76116006)(71200400001)(26005)(9686003)(7416002)(83380400001)(508600001)(86362001)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhZZ0BplSBMuGDl1ApCXPyaAMiBaGLWZFyvis6Jzf3D3JbeD0UDAtDh2QDDM?=
 =?us-ascii?Q?XTyCV6P4oeIbpp35JeKgpVFy/jBUDxxTs1eNDWrqkei8HGAHn5X/fQU1p2K2?=
 =?us-ascii?Q?Wy12P9NQIiWBaVkal6x6wLwi2wLMXFr5Kya1+Ikj8rus6iEL12kWeIhOnoyu?=
 =?us-ascii?Q?UbdiB9V7IgLs9moXWDjhD9krkGcT6wCVZoOFf0Ln1jAX+Q5naVf0asAvO95s?=
 =?us-ascii?Q?jh+wjUF05k0oZkOZKqZctq6/9ZnuM3zmC44VkOXmHjCOkNNOp+bDhOu00kdM?=
 =?us-ascii?Q?JYi+8Gh9AkfZNkznmeBz1KN73Wlm65xzWlXAqwH+IUGJHGLmNvnNd3lqQH69?=
 =?us-ascii?Q?hveuRxZd46zNeeD3UPoEt9foySPTGhwsn/4pWPDN6OFAAvzoZYqLolhwEnQ6?=
 =?us-ascii?Q?rCOc5U7Vs4FuUHhA2O2ZuySmzoRiYGENioHNuQcF1ujeMhpirAMaldlNQAR3?=
 =?us-ascii?Q?33A2zo3Dm14uA9uLDiMZlVksDn5+Stf+8GlpuTT3nUrA9+AJvACyLvUOC7cC?=
 =?us-ascii?Q?VbvEjwBL2aqJuHc7UtM0xRiA9V6q0hVKjEr2p21b9RKrl4oicfd/xnuoiQbm?=
 =?us-ascii?Q?21xZG9edAEjcKw7d7yJ/D1vLJpW47Hw+aQbgHvxgavYFKDeqgsgxjPTayAG5?=
 =?us-ascii?Q?ywKr9qGJIw/ULXA2/RVnJRImswqKKIae2X8LjTXThCRwSHxf6DbPNi47LjSC?=
 =?us-ascii?Q?7P951tXnuBHwzjbZhzbcasCD00B0do1I3ISDyHKdKMrIMJryIe5/4pfu4Jti?=
 =?us-ascii?Q?9YNtCYPxH/tBMFkpzW0jUn+DqTqx2FsXPzn6vp0erN3PYrX/CssiMmzuRR56?=
 =?us-ascii?Q?ssQlE04x1QxBqDoLJOloJcJ01cqbJpfKB/kCDM0zD6cHWLvadRJnYCvVOXkp?=
 =?us-ascii?Q?17jWK1o+xO62un3gKx4pwA4urWhDUvilmJYgyYB6MgPsZTVlzJwBv3jRgwi3?=
 =?us-ascii?Q?NADwbq5KUEpdczgdbN6QlCPUBgjtMF73uzH93q6mKYKan1Ecyx3VsZ0YoMca?=
 =?us-ascii?Q?JkPsNYXGZQcCNf2uk64bG7CrfS70wcR0LnsnNmb2Vz6kobrv8A5zIkwdrjIl?=
 =?us-ascii?Q?QodD5idHMvzeZfG9Anc3uioQe2iCC+rc1tu90Ws1Cb2pm8x17dAt9jmdFxwX?=
 =?us-ascii?Q?KIlh8dOJqXjyWQObLz7SiqM3rodSh+Ms8SJUONkIWXKkiKYqz4Jt5IQLX9La?=
 =?us-ascii?Q?rw0pMq3hTPbL4SPtQtVv8gSxcU5tep1jEnJi4aiowX/2EVOyuAH/PCFB2oYD?=
 =?us-ascii?Q?yVSaSwR6W6RqjwPP0S2CtXM2OtIDZ1T2MtamqNuynehXwgFkDQJoo5fev1jx?=
 =?us-ascii?Q?uNm1SlDbZI2lfVuoeOQ4L3J5fkO+nYBoQ8ow+MXaqR11VHf3tDhrTTiBDnbd?=
 =?us-ascii?Q?p+n/mrtjG3Xk42zjVLFYO/eG7KUF0iU5n+8C3FhUKenQ+FLe7TOIqFMkxdH4?=
 =?us-ascii?Q?ICNGIt/8VX2Tx9a0fNgCVyWbX21f6Vf2yvrMEw5LEfp3YuYXU+5AsnqcAKgE?=
 =?us-ascii?Q?LsNI6Gw2Tja0Gh/ur/VbxUcV7lf0gwuZX1csThClRrXeMv5jJa1zaBJLeuM5?=
 =?us-ascii?Q?RXoWOML3ipuUS6imx15gA47u/98+Jyw1Jf+wTKD6JoGuZhUYG10TG0etgRcu?=
 =?us-ascii?Q?yzyIJ1IZG6VSyPWs4VSKL2BRKM8JLnIPbQStr3uwGq0WATns4g2t5K9TJDRn?=
 =?us-ascii?Q?qBqg7ueevEbmM67IXg7WGCdz+myZPbFQnUpSvGAeotNAM0R6iY4DHz1i9PgW?=
 =?us-ascii?Q?5HxzuItQjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d90649-6636-42e8-3162-08da5007fb8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 02:20:44.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLs6E/yG9QxAIOYMjayPAKd4WXH0q+AbGeTJqZyc29xTPVgDh+xCWgIXc3tj9YlRd8XGRqpocaMPJUdPeoyzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ast_udc_ep_queue misses spin_unlock_irqrestore in an error path, this pat=
ch
> fixes that.
>=20
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index 1fc15228ff15..6c91f7f288a2 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -665,7 +665,8 @@ static int ast_udc_ep_queue(struct usb_ep *_ep, struc=
t
> usb_request *_req,
>  	if (ep->ep.desc =3D=3D NULL) {
>  		if ((req->req.dma % 4) !=3D 0) {
>  			dev_warn(dev, "EP0 req dma alignment error\n");
> -			return -ESHUTDOWN;
> +			rc =3D -ESHUTDOWN;
> +			goto end;
>  		}
>=20
>  		ast_udc_ep0_queue(ep, req);
> --
> 2.31.1

Thanks for the fix.

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>

