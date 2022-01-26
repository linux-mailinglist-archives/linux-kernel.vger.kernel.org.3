Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1749C52E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiAZIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:23:51 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:3655
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238350AbiAZIXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:23:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEhS0WsWgR0m2VMK3QJsNRTRvl+sg8N4cK26VVSJWxwdK14udfg0zYDm9IsW1frXkzr1BNpqogoeHZSZzAqTKgEqryUt1aOB0lnJq0vmxJTr0ClN2OZ99TpQXdQK+EgJaud/wz1Elj35ObkYVHzG58b2kgP0L6MVIA6lEMCdVDClHZ17wt/NyN60hjx/6/7JOBaGr687krybuPxnEMWX9J73af76SDs16oewt7YHwXMM0iYXjW6oVupOdFfUPBYw9eaXrlw+axsQRZTihGUulSBAi4I3zTLlmRyUFf4BxnsxPGL4p3M1PDvSupQLxNRr4jVJsIQd8kC6L5umHpvbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL+B0denpvp15mdn9OGgG/uQJlX4uTlRsg1FqEuB0J4=;
 b=XD1z+weg+AW+mwy/CkxyNZSE42DsYJNZsk2/YPixdUTzN7zuBBUL4QWOv0ylSXsMZ0bMCLLZUTSsb8uBQedT1shB2wMyhUUzxUyOytV+qI/WOwvQ7+cl7HGvyI1c6GuuWGSCklXewx1Gm5liU/eVaYNH6jEQrI2OEDBE/7xzXeevjCQO5FWx7HzozseIudpJS41E2jaQqYTjLh+oANVR3/T2dZL1UMtSXac9NeE7m0fF6RZRntLMzLgrIv858hG0yJW6Rz7mua75Xu7q66CgLo/iDJKfNXYVjsw9HvXConvmmPmmewQoOSSKrtRZGRpNDf+q4oFSqn16Y9u0owIJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL+B0denpvp15mdn9OGgG/uQJlX4uTlRsg1FqEuB0J4=;
 b=eaVJYxlCPkgbwQqi9Nj+KtOfB/V0ekdw385hj42OHYivTMZgKvZZ+E8psYRi/FWygmDB2Meyqp3ZLWrlkib9iTVx1bxlLbjQRz29snNFMgt4svnevVlMkc7enXpzupZGCoilFN7vKb+j0pPLI/hBziZ6+LyDrtdhAeM4PBVpbQY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5526.eurprd04.prod.outlook.com (2603:10a6:20b:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 08:23:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 08:23:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: imx: add get resource owner api
Thread-Topic: [PATCH] firmware: imx: add get resource owner api
Thread-Index: AQHYBpp88Wk7iU3DuUWNyL9elrFSa6x1Dtlg
Date:   Wed, 26 Jan 2022 08:23:44 +0000
Message-ID: <DU0PR04MB9417B5E817D6A3FB162030BE88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111032147.342012-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220111032147.342012-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf985beb-f038-4f53-3ee9-08d9e0a52aca
x-ms-traffictypediagnostic: AM6PR04MB5526:EE_
x-microsoft-antispam-prvs: <AM6PR04MB55266791CE51A9B47065174D88209@AM6PR04MB5526.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ccak+fc6aW40tKcWinoyHq0r2Uj5DEVizE+OseBxNLEsgDitDSC+f3SlJXlNGOy9sU/nl3Jwd/1P6j2x9DpJIPqtySPn7BF7w41ngo9GvHPAzuBOWov/kbNcaUvqjXpiI1eoiVMOFQLwk7mcFhC6WfzdIZSufjc11Q2RAhE119JV98aC94AAR+5ehFBeylGFc/Jd6Uo2eizXT+6ZG6vvCsXT9crnq5lDkodQlboUYlCOwTWSHC/8b1U8AdD/DHvjDIVzaPWu6DoE2TvdKWXsFwH4FwM6sy/6mLt3q0tUaFRrwnQA1Ck5s2FPNvpX4lKEFtA2DLbmeb1oYlE+RWMQ8/o07Gq50kV6nFD1a34WFrSUo+4dbuQ4OQG3ymlqs07yBEyron9lB7nl1G0sXD0wu6oP9kTnxBEdDCO9MU92cQDLLy5AeJbh1uOVSTs6UK+BsAQCcpySesy8o6jZmDvfDrHWXKT1/eskJ6zQ8Gcil6UnnnCsaTq+tGYtA/YUwRGe0KMMznRLxrxCghOELd9B/7hok6Okt3q9AELqu80n5pCf37DklzzMa1fdhjjj2ueccqbtIXX0cbzPVscrGPrXa06SWwMmo7GTbWa1SrjIWTiTkV6C1CJ3eVQ7GSx7bmz6IfahyuHPCQeKo4Duv8fy3Pwhz9aFbMUA3jev6VouphloCMBFrN+9PKVmXm47J2BzeL6B5KubP+/FBnFvmyIrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(66476007)(66556008)(66946007)(2906002)(8676002)(64756008)(76116006)(33656002)(66446008)(52536014)(8936002)(26005)(5660300002)(4326008)(55016003)(44832011)(71200400001)(316002)(9686003)(110136005)(86362001)(7696005)(38070700005)(6506007)(54906003)(508600001)(122000001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ma4RMASesJ9uTz0GFZ8vVv5hHgPTocQx0NpSiJ96FaWCJBQquwxDXeek5Az+?=
 =?us-ascii?Q?VUakWhREq3tZoInQyI0tpD0Z9ZmSpvp5r3VW8f4sew6HgFDDakEO59+7xX0H?=
 =?us-ascii?Q?QAyuZeUM24GWUqj+FJ1f8IGYdveVioRqzpNgGnOF5HGiuyo/C5uSerTkjLIZ?=
 =?us-ascii?Q?e+sNNAWS2Ekjo8UPL63wgenC5eVBpNWBYgfeUiT+UMcpXlD+ONW4Tv1QUKvu?=
 =?us-ascii?Q?YqL979TZcO/ECUTqgg0/GJ80oYVWCpFlRrRsrj9Hfl7wy9XT83V49fh4ORJK?=
 =?us-ascii?Q?SXU/jajI/DU8uQAC07DSG/A6HAYjLB9tzkweVqJ9y86Ke9FAPR2RQ5tOmFBc?=
 =?us-ascii?Q?BK/fvXvB/B0nl3/j9EbW6TqsDZdylxpDJYTZr3rybZFu0ATqNHkxt2BsTcdm?=
 =?us-ascii?Q?EXcEb+JMXhn4NiudSpgcUN2Q80MNZTIsRNaHH9+8PREYwNl6+J9fsKGnnoeN?=
 =?us-ascii?Q?hnyA9TdySIlvfvBHDcPuAaUEN1XA0rBndYaKpGPXLwJiBBFlyp5bMbLBalpg?=
 =?us-ascii?Q?SBsYOLLCJXw8/rT9Yxld3w0ujXCN2FCx++kPi639fAQJODrCDha+NwjtEEda?=
 =?us-ascii?Q?XkhnayUk9Za0dWmKsN+b2KXB/Ps/5qQ0rXeaadeQn3OBibPqMdROqBimFs60?=
 =?us-ascii?Q?8A031jVv+JExpMpf6fKi0SeG21ae2tk5BnDHFeFuRqBa0LAGYdsbV5laPr00?=
 =?us-ascii?Q?m3DKyeulQjBNMDiOJalqMIafzL6acdtxv2V6jvzU1CCIMswQj0s0v0giF1S4?=
 =?us-ascii?Q?9v2Y4J01QIXRgZ8tmD68lfHOs8rUBbqhtFGeoF6x+SHIv682H976jFQlMvQO?=
 =?us-ascii?Q?ZNJ37aQzDxR31WuFHjrjk1KBn40E+jy/78tG/8g8PG+WzjxIgG8U8y6o8Okp?=
 =?us-ascii?Q?CWfZRnA4GlPQnUJEpzNXzLz/XiXa+hyuh9NaFy8cSR+CIKtKx8THCGhJJP5f?=
 =?us-ascii?Q?dNUfLEJ5PFtm3Ishn0DxnJr5hn7hMDnY4vPdt3MubmEPVn6pubBUswAKIu+G?=
 =?us-ascii?Q?zoL0Y4OslqJS3ieVq7zkK3szZ4rbhXh4C7FqvVytkNNAI/hZUera6AqVVjN7?=
 =?us-ascii?Q?hnhv9jwCtX1pGXa+j1IpkNeCOSP24HdAi5x4KKJ3/CPx7NjEoR2Dclf+zncU?=
 =?us-ascii?Q?w2qxIBIOVe2c4ZTQKKcpX2ZzmCSJpkftYhcSgJUbEcKn0LnJkgYFnZw11t4u?=
 =?us-ascii?Q?LlAbvnMHTTSz4UxtlVEkL15eVYbX6n4AJIdyTMBTevp7mWDnssQdpyv4BpdQ?=
 =?us-ascii?Q?+E+kM+QXKxjL2KUuoj8WNfGjz+hTYciLo5DCTEGeb2IiCQUwoPXfaTt6gl4J?=
 =?us-ascii?Q?SI63+WD4f3iCIqB8NiZ6/Y8q3WnyVkGlGtTsXbDMGNZbW+2iJsZbIYqJRbVk?=
 =?us-ascii?Q?nz2Mp+U/83GSzUzw4t0Rbe2vJiee0+KpIPOfR2Z8mjmhfglD1fNuGP/2YFCv?=
 =?us-ascii?Q?WXvTHfh33OTrjbqj1JJZwZbl9OLhngKDfjWM1bFi+O37RbA+ERTJf06ArjTC?=
 =?us-ascii?Q?eYOBT5XXjOpOMJ+3xWDSu+sABkOcIRgYnBL7cOJmkgLRJTe4345eR64noGRT?=
 =?us-ascii?Q?XzDOq4uJ7cy/cU1mkzN5r9mwt5t9n39iQTCMxy1L3DtHg4JYSiqUM4Ryvx5O?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf985beb-f038-4f53-3ee9-08d9e0a52aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 08:23:44.0339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLW06P49o/2Z1ssHNCO2x5T00wRcVCxOZuajINkSykd0psuOg/R36lVzFwWpaVlin3pDUknjeqbmy9gMtLSM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] firmware: imx: add get resource owner api

Ping.. we need this API for remoteproc partition case.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add resource owner management API, this API could be used to check
> whether M4 is under control of Linux.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/rm.c           | 45
> +++++++++++++++++++++++++++++
>  include/linux/firmware/imx/svc/rm.h |  5 ++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c index
> a12db6ff323b..3c3605f98123 100644
> --- a/drivers/firmware/imx/rm.c
> +++ b/drivers/firmware/imx/rm.c
> @@ -43,3 +43,48 @@ bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc
> *ipc, u16 resource)
>  	return hdr->func;
>  }
>  EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
> +
> +/*
> + * This function get @resource partition number
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[out]    pt          pointer to return the partition number
> + *
> + * @return Returns 0 for success and < 0 for errors.
> + */
> +struct imx_sc_msg_rm_get_resource_owner {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct {
> +			u16 resource;
> +		} req;
> +		struct {
> +			u8 val;
> +		} resp;
> +	} data;
> +} __packed __aligned(4);
> +
> +int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource,
> +u8 *pt) {
> +	struct imx_sc_msg_rm_get_resource_owner msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	int ret;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_RM;
> +	hdr->func =3D IMX_SC_RM_FUNC_GET_RESOURCE_OWNER;
> +	hdr->size =3D 2;
> +
> +	msg.data.req.resource =3D resource;
> +
> +	ret =3D imx_scu_call_rpc(ipc, &msg, true);
> +	if (ret)
> +		return ret;
> +
> +	if (pt)
> +		*pt =3D msg.data.resp.val;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx_sc_rm_get_resource_owner);
> diff --git a/include/linux/firmware/imx/svc/rm.h
> b/include/linux/firmware/imx/svc/rm.h
> index 456b6a59d29b..ff481b23ea36 100644
> --- a/include/linux/firmware/imx/svc/rm.h
> +++ b/include/linux/firmware/imx/svc/rm.h
> @@ -59,11 +59,16 @@ enum imx_sc_rm_func {
>=20
>  #if IS_ENABLED(CONFIG_IMX_SCU)
>  bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource);
> +int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource,
> +u8 *pt);
>  #else
>  static inline bool
>  imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)  {
>  	return true;
>  }
> +static inline int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc,
> +u16 resource, u8 *pt) {
> +	return -ENOTSUPP;
> +}
>  #endif
>  #endif
> --
> 2.25.1

