Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3825C4A911F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbiBCXXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:23:21 -0500
Received: from mail-eus2azon11020015.outbound.protection.outlook.com ([52.101.56.15]:48918
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233188AbiBCXXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:23:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQO+lX3uRsebar1aXQzIJD9BP6ItJzsdnhfZdixyGtdUySWTHvgWPxN7SKT2pbvPZ7kqD8KRy9R0aAzY1U3LA13gEFwC5dG2dg8HNQnx3y5Y960Fb5SCXue5XQ/+5WGFzLk66QbqUvU+6mDAkB7GSXjuUDGN65wfICQmscwqDc777MpiwKKkTbq7/n8+spt9l+5Lg2D6MqybZmgK3xwpDYEFUP3Ssf1vHwBfzZhcki/x7dHJ/hYCMpfx7NmyOw5PrinKvvqacUVYqOeKZHZvw+cEb2oS4sc1u383t8AA6coKQKl0Sq6gGwnxjOnqbql2cT83Bdnsks47K2GoltwEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02bYAzN904HdZ1aw7tzxzD8Mfm0JPTXik3SCE4pA520=;
 b=GHiirTy7NuNFu0Jx27+49oD32XyzyzN9L488RDKTMg5cBKqCXdB7/A33SpGx3EE5LmZ8ZQvP3KrA4yy5N5oe1NpM23H4F3lJ7THUDSwJoXs3wZNv5dU+dUamaTLQ0TSnKpH0VaACGytxsibgcRu2Fbg34+8MeyOSwVGNBp3FCw3/SWSItlwZJhyzfmjgDwHyRgErRrLs4xXYPM65f6oB73oczUZbIc85UQ5OhyZHjx17a2bXdcLbxNVEuGyY9ptPdtuvrzfUP8p4llDgRI2DyhCH7UvzSkVsZ+JQMf1HHMr729b7lwcOvjLmc8ntdj2ZSDuylO01GXPuMxV55MP4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02bYAzN904HdZ1aw7tzxzD8Mfm0JPTXik3SCE4pA520=;
 b=AuE0kxs3hFTs1eLf/EQ2KK2FwKvMYqNcvHL0WlRiLvrWNvcOQzE6By44QV/lgj7NyLadM0QgdXc8hlgrOo/HSxya7fFuYiZHl14tYnbdeYrBorONSpmM1+mLTssokmmt+TfCqFEXkE0UUg9FiKbhHwWGCLcC5O8GOvzWUxwoOpU=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by DM6PR21MB1308.namprd21.prod.outlook.com (2603:10b6:5:172::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Thu, 3 Feb
 2022 23:23:15 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::2963:c3c2:191d:70a1]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::2963:c3c2:191d:70a1%5]) with mapi id 15.20.4975.005; Thu, 3 Feb 2022
 23:23:15 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
Thread-Topic: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
Thread-Index: AQHX9sHUjE/wr4iCGUqf1MzIH7Mjp6yCvHNA
Date:   Thu, 3 Feb 2022 23:23:14 +0000
Message-ID: <DM6PR21MB13238271EE4163A0F8A52B19A5289@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
In-Reply-To: <YcJiBk5f071eJ5+n@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2ca019c-3f71-4f61-a583-f3f35d64d920;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-03T23:22:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 825ca062-40a9-4eb5-2758-08d9e76c2767
x-ms-traffictypediagnostic: DM6PR21MB1308:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1308414DE64E8DEB0F9D3D51A5289@DM6PR21MB1308.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqozNXTMgynl8CWm5soOH8/ZZJsGnmckxVE/nmkfS7uNwRbyNCFVxldaiw/0f3ovcE4geiwrfMD2O+/FVwz//Hmy5ViNDIYhauogP0io+soPIPFZVktsquPLI2KeEXNLxXZAIpxRcdqQQIy9XiBRXqGSLH8O/IMguOFMw57HBS6NuAVOECuyX4S81H4/vHLAK53i80IsDkIub4vCcQoLWW06RcowSTgdCIzElYNobFyMuMeQwFOr5SGUyEyZhVbTGzIysOPbeAVeVItfuIoEuPr5gswlEglwv2ZNzFBXAamhl9/80meCmqBMwhHUs44WpHdBYj104Dbj1kCKWHcE6ajsY95Sgp4B7hBHCEgphLAftumjTQ1u+tmkqFV62T5lMF5D+c4oIMq5J8VNGdXOVAYUMfLzRXT1CxV2kTD90YrnjPe30sOPcvLgpfKO/4BeEFG9Y8RJTI9kc6mrl1MJvF2prbAOvCpk+CK4MLjnAPIfrXnMgqTTdlwxfkx9n3WeDiH0tF2hFiMMiPtWttN+pShaB153d6pEpRugcNsTSFmrTLIxt7G6EMtxS0I2CGnoNP9ntYjZ/K2l7FWyYavZr1xkp0PJzBOl55fVMeP64QIvcDKFC1VCYXX/GEKLiesrRvvsVSn6SV+Z01jJ8hqmu6N5gf57bEKmapFAEzxz4ThvAELgJ7wKy0i8Ap3ZvOGYH3Q/MiebZ+NVPYN3sfaXJoWSx7YYRLpJcFQZhBKCXTA37J7zBh6guqrf+F3iWvQ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(64756008)(7416002)(186003)(8990500004)(8936002)(38070700005)(4326008)(5660300002)(55016003)(316002)(52536014)(66946007)(76116006)(66556008)(66476007)(66446008)(8676002)(110136005)(54906003)(2906002)(86362001)(82960400001)(10290500003)(71200400001)(508600001)(122000001)(9686003)(6506007)(33656002)(38100700002)(82950400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8fFrai2+vYk++3pgTAQxl3HXTnnSOc8YBLKjHRrgUVhK/9mcth1+a7qL51pF?=
 =?us-ascii?Q?6UksX+Fti4U3wZhpUC6qQx9jyzJ21pyqfd9wKjFJKDD/NlspBHJ6+64VA/Nh?=
 =?us-ascii?Q?rQGFoYubtHSPK4jOnasNxPMNFi3XRpmQ3+IWKTNRhBsGJLcAE8PW6mmh7RDD?=
 =?us-ascii?Q?IYuvHM/HvEn/F6qg4wrfJMScbY6+gdg1Dy01geTSra9/dv5oNKEpyoy5Z0GD?=
 =?us-ascii?Q?D/yYf/Kyn5Jw9hC6DTGnHJcWPisNL9sxPLKRcztRJ+SAFzJaZRoVYFWtyB4O?=
 =?us-ascii?Q?B0G9GDi8Ymn4gk901F/6ViaCVdrD1F4h2OEVx3W7YgycY7lguzPWSXbWOeHv?=
 =?us-ascii?Q?61/EStleECfnigOeFVFqSKSIvjLa02JU9W5Ub2nZX0ckditYJb2ji/S4Y23o?=
 =?us-ascii?Q?So5PPNCAG/wi3j3TQDpv/3NUwn1YLVNJZTu8V7FwrvYFfrFS6cX1+dluZ848?=
 =?us-ascii?Q?kJLuSFffPVPXuPBAgJ9AMm9loUShOm56IUke+uFlGvySFADYVjxStxdLULQz?=
 =?us-ascii?Q?yBIcq7VRE44i2fHteWaS/PpUKSJCIQoTAPUK2sB0zdI+sfAZE0hyk3nxSP08?=
 =?us-ascii?Q?hsplCJdfUUT1nXHk30BU6pckygI8PDKDUztu7jK1uHNmtiWsl/3L+KBuGymd?=
 =?us-ascii?Q?TVY4qNlPK5azAOeUbhDXOW7QvB7wKUtVRXsqPOh9eoFZRyBL+ybeulPT4Vka?=
 =?us-ascii?Q?1UeBzQk5W6qRJiNMIq4mGBDMax8VJlQUeGU6WjfnGDUYngJB4mU/DpBDFCBA?=
 =?us-ascii?Q?2R5LAYzeFZMqIrc6prAEbp6PjSGLjsMJxehJgWFx038aBi2fzIABkthzJGyV?=
 =?us-ascii?Q?b11tcZNCr2QxuhQN/stz5qwEEKlOo9B/QBJAbH6gzzp2dTSU/QQU2LLqRvzX?=
 =?us-ascii?Q?lDXO9i1Z7lX2+GETp9UgBWKqcsAzWP6CpRC26PE0saW1w0wbmHp7ZWF5gN+3?=
 =?us-ascii?Q?d3Zp0hdlzfnC+3/yq/XnxXVn5YAEVVJt7ILbcBNV75xh6loNBMXloazQdlz5?=
 =?us-ascii?Q?Fhxc2uAH+28N2psrNXPGbuE+xZqLJP3Cjtiio8Oh/Q5ZYKqb5WozlbAGRKXj?=
 =?us-ascii?Q?jvsuAS+tSaDG739er5U1HzdN/y8YH1ojAkwGlo6RDJ4U/deOfMZrmPip1aU5?=
 =?us-ascii?Q?oS2IKgC2Vdi+FxaWWKgRSN00x7qDh10aTvkxVTwb/W0O8PP9OtyNF2bdHKEB?=
 =?us-ascii?Q?Ke587mE7foJ4GkJPF22BIb+4B5YSMq5l510O7eTA8kAN7eunXxmddmG4P2dM?=
 =?us-ascii?Q?JgzIvlHynSBFrMy+7JWF+OFNmysid+FzUcg+ramQ5GvMY/17viCqX2OMA2QF?=
 =?us-ascii?Q?ODMgsihZPRF3hO9uFQbwmZbPvq6KjEChWFAP1hJCGvGV+VsNuf9Fny59T5jN?=
 =?us-ascii?Q?SpMN/Cko9fuX4K2+05Vbu5MYYp1ZQrbh5OXLLjm4+zNVHwypFGLNojnIh/lC?=
 =?us-ascii?Q?B5HhtpvaK5Rv4IdYI7/rIEMefvXPWiLDMt2A892ocLbmw3Ma9qD4epGCpdMT?=
 =?us-ascii?Q?/K4tlEtAeIZl6F50Ncz6nTTft178ZIAfBm/EzoxOn+1QSI/8XiZU4z273NrH?=
 =?us-ascii?Q?HAExU6Yn/KMwmug65unXKwkWNpI6vZShDWBTyI2hpJYXnRiePIM8/s8s1Xqw?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ca062-40a9-4eb5-2758-08d9e76c2767
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 23:23:15.1942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlFtF69kpB58jKDpF2q8GWC8wGKiBH/oiTLsCSOsTeVWjoNAm49cNSdPJoZaBCD+seFapMHz+4PGm/6JhFFy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > +
> > +maintainers:
> > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > +
> > +description: |
> > +  Defined to expose information that is used during production when
> > +  device is in manufacturing mode. Some of the information included
> > +  in this imem section is -
>=20
> If this is onchip sram, we have a binding for that. That's not an MFD.

I now have this driver working with nvmem, but I could not find the binding
that you are talking about here. Could you point me to the binding?

Thanks,
Jarrett

>=20
> > +    * board_id
> > +    * battery_present
> > +    * hw_init_retries
> > +    * is_customer_mode
> > +    * is_act_mode
> > +    * pmic_reset_reason
> > +    * touch_fw_version
> > +    * ocp_error_location
>=20
> nvmem binding doesn't work for describing these fields?
>=20
> > +  See sysfs documentation for more information.
>=20
> sysfs? Not relevant to the binding.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - address-cells
> > +  - size-cells
> > +
> > +examples:
> > +  - |
> > +    / {
> > +        compatible =3D "foo";
> > +        model =3D "foo";
>=20
> No need to make this the root node with a fake compatible.
>=20
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        imem@146bf000 {
> > +          compatible =3D "simple-mfd";
> > +          reg =3D <0x0 0x146bf000 0x0 0x1000>;
> > +          ranges =3D <0x0 0x0 0x146bf000 0x1000>;
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <1>;
> > +          status =3D "okay";
>=20
> Don't show status in examples.
>=20
> > +
> > +          xbl@a94 {
> > +            compatible =3D "microsoft,sm8150-surface-duo-xbl";
> > +            reg =3D <0xa94 0x100>;
> > +            status =3D "okay";
> > +          };
> > +        };
> > +      };
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 13f9a84a617e..5d0ca2a98b57 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12649,6 +12649,13 @@ F:	Documentation/driver-
> api/surface_aggregator/clients/dtx.rst
> >  F:	drivers/platform/surface/surface_dtx.c
> >  F:	include/uapi/linux/surface_aggregator/dtx.h
> >
> > +MICROSOFT SURFACE DUO XBL DRIVER
> > +M:	Jarrett Schultz <jaschultz@microsoft.com>
> > +L:	linux-arm-msm@vger.kernel.org
> > +L:	platform-driver-x86@vger.kernel.org
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/platform/microsoft/surface-
> xbl.yaml
> > +
> >  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> >  M:	Maximilian Luz <luzmaximilian@gmail.com>
> >  L:	platform-driver-x86@vger.kernel.org
> > --
> > 2.25.1
> >
> >
