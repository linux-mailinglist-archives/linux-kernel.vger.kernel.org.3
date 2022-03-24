Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67D04E6957
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352948AbiCXTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiCXTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:32:32 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF1AD120;
        Thu, 24 Mar 2022 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1648150258; i=@lenovo.com;
        bh=B1GJ+v5g39tFS10HfNaJ5VyKurY373EObSWJyW7KI2U=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=r7FiHgl8YWKnIaFxPvqpySLy7tF0wvCDMYUEXQ8D4yp1mbTeFgFySoFcUDzVW28uY
         kCz6AaJtIND3SrNWS3NYkntnHIE84fXEo9f1cVjc+qi8t6fjf79Tz2f0+osJTW6vB+
         0oQ8o7qe4eSN57OIvvijmCXbwfaISBWjdwBGlVqrd7CnhPg+lQq41Q3gRpKjsGeOa2
         iEou1uwY7LgqMTJc8xHpRgQEVH+qSxq4Jbwlr3EWByvURducIQteU3EGYqBTGBoqfK
         lO3Td5DLDXkX+Oc4BC1UsrtaXi+5we0FfbVzyN03/+b09xyl11y/yMRfdbo+rC9Seb
         Mc/LsubpMxRUQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJsWRWlGSWpSXmKPExsWSoZ+nrfvhmE2
  SwdHzphYHj2xks3h7/CmrxZvj05ksLu+aw2bxufcIo8XvH8+YLA5MncZssXrPC2aLrXuvsluc
  3l3iwOXReOMGm8emVZ1sHvNOBnq833eVzePzJjmP/u5j7AFsUayZeUn5FQmsGafvNTEXvJKuO
  PpyM2sD4x6xLkYuDkaBpcwSFycfZ4ZwFrFKvDjwlg3C6WSSmDzvHjuIIyQwi0mi9dVjoDJOIO
  cAk8THS9UgCQmB44wS3YfWMUFUdTJK/Hh1igXCmcAkceT6LajME0aJuz2foZx7QD3/1zOCDOM
  VsJXYuLaLDcRmEVCVOHftEzNEXFDi5MwnLCC2qEC4RPf+/awgtrBAlsTeqUvB6pkFxCVuPZkP
  NlRE4C+jxI7le8EcZoEJjBKb++9DnZsmsfPRRiYQm01AW2LLll9g3ZwClhJrJx1ghZikKdG6/
  Tc7hC0vsf3tHKheZYlf/efBbAkBOYn321dA2QkSzVOOMkLYkhLXbl5gh7BlJY6encMCYftKvD
  40nw3C1pV4vuosVDxH4uOx2UwwM0/1nmOawKg7C8nTs5A8NwvJebOQnLeAkWUVo1VSUWZ6Rkl
  uYmaOrqGBga6hoYmumYmuhaFeYpVuol5psW5qYnGJrpFeYnmxXmpxsV5xZW5yTopeXmrJJkZg
  0kspcgjcwfh2xU+9Q4ySHExKorxvNtkkCfEl5adUZiQWZ8QXleakFh9ilOHgUJLg5TwClBMsS
  k1PrUjLzAEmYJi0BAePkgjv6cNAad7igsTc4sx0iNQpRl2OK9v27mUWYsnLz0uVEue1OgpUJA
  BSlFGaBzcClg0uMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm9QOZwpOZVwK36RXQEUxARzz
  /aQlyREkiQkqqgUla5WifTsGqJQVbJiw9odXTbNRpzFZlqZqqLrX/nM2zRXfftwbP/ebPJbdc
  PJw5Tbv0p1/G06W3LZ5tEF1YUPY/2nRG3u9fD9rnX3Pb2v118S8d+XhDs+r4JVtrLkecjP/Ut
  GU5t6L2/Q0BX76/uJ2Tdyrs2h6mgzvzj+n0RW51SHM+7Xzxs9iE+i2yCw1KJnkXciRqCFycVv
  RG7da1KRrWHa9dTP4tvzUpdwGvzvOcGyWqqy7c01mQ86O349ds5egKfrujdZ/TPh2StPDSvbj
  6YPKv0NdmfVpbWjmnbVgs4/vcOG/vmtgFFh+kPldwN7+4+jfp9uqE5kNR3X8/PWDk/+e4f+Mz
  BmafjR9f7d+nxFKckWioxVxUnAgAyL3r6YEEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-12.tower-715.messagelabs.com!1648150255!38979!1
X-Originating-IP: [104.47.110.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22098 invoked from network); 24 Mar 2022 19:30:56 -0000
Received: from mail-tyzapc01lp2043.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.43)
  by server-12.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2022 19:30:56 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2YH/f3ak3msYH+7AzvfI6wzWL28zoXiodfrf+0wJ9jR+XNnavHnny9ANGv2gy4nv3JL4QcytIz+J7lkzF7AVokgM+D+hSJ1O15meP0HV7IS/VyiPguELH3nW6DiJ6pO8rpXIlofpF1bckx4aljEaUhQURtzxj7ex35+lstpExoFCYIbt5vAWOj0s5FD3GaLr3sO6JeMvQ4quHUwKCnM1d3vz+6mYQeZE/Dnw1wklv76yrUxLcD/6IUTMhzp+q1Gk6FSt7mpEbnioMZAlTnzYzb5HNQo1M+dAyAgXxH48w2jM372a1qE7B9qstLFPD9RHC6AhWohQ6vQGrDHtqfjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1GJ+v5g39tFS10HfNaJ5VyKurY373EObSWJyW7KI2U=;
 b=g793+HmVJZVX65kinWl9VxmGnY4fUL4ANh10Q/jPPeQG6TaGgBxGUtCevmFdqYHlgtEuuk6L2ECvRvv73T6S0fHSq/821lqgiiHsukA54e3YtHj3mBwFeCwsgBEYRefgJ0qDqUzwEQQRO+Os3pp7Ku2trQ4kU4JXLtORQJzLIIAmZH2n/yGe7kSLVXy4FiJtf73lXhuN2Q2nF7+qNCZwYVHHUmvg6NUvBuIDEWZ0Byrm2gP8Ih8z11Ei1bdEvZzdbvxJ8A1SlwDIP9uEcqlMiz3LyRxpfnYzqRavnn6EVfp5RyTjBBZ0sCOrSWETNAsUGDmI00+omLcMm3MMv9mmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR04CA0189.apcprd04.prod.outlook.com (2603:1096:4:14::27) by
 KL1PR03MB6391.apcprd03.prod.outlook.com (2603:1096:820:96::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.8; Thu, 24 Mar 2022 19:30:53 +0000
Received: from SG2APC01FT0007.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:14:cafe::38) by SG2PR04CA0189.outlook.office365.com
 (2603:1096:4:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 19:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0007.mail.protection.outlook.com (10.13.36.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 19:30:53 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 24 Mar
 2022 15:30:51 -0400
Received: from [10.46.54.2] (10.46.54.2) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 24 Mar
 2022 15:30:49 -0400
Message-ID: <b213c5e9-7b8d-491f-84cc-2a7c4825a547@lenovo.com>
Date:   Thu, 24 Mar 2022 15:30:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [PATCH 2/4] Documentation/ABI:
 sysfs-class-firmware-attributes: Fix Sphinx errors
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220324164737.21765-1-hdegoede@redhat.com>
 <20220324164737.21765-3-hdegoede@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20220324164737.21765-3-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.2]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb7457e-b118-4d47-257c-08da0dcccfd6
X-MS-TrafficTypeDiagnostic: KL1PR03MB6391:EE_
X-Microsoft-Antispam-PRVS: <KL1PR03MB6391FF1BB4383C85AD59CDF1C5199@KL1PR03MB6391.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDe9hhdP5cqE2SEUUMVXuch8vPS4bLPycDD0hSf3KVK0lHCSEXNiD8qqGgCrEEKAT12NeITnAeLJdj3igXKWZW2kMEQdmKccXAmGiuWmlQ5sYpVLyMp+aVL3pMO4b3Gn0x7xQj2HYKOD9jJz5p9aD3UUTZOi+MctuBTV9J1uMRIDnQaXov6YqLLM0CPHDPG7roLk2UCv1lkJtJ9SncOwt77EATQH0eV6gbSdJnqxqNkN8hcWvyPGie+r1NXm7WqOMTP2ARDXVCDq92PWnWOw//cMQceSozmgdCds6q/eI1+n7yw1xW7NKpgMaGtrph/KOaqQm6Aqu+WLuxSJmLzbdlSsV4dhwXhiZDJ0vJG24scpcf+vrzCrId3/jyGMZzByOfToNYijB2Y8iUrLURPn4qJAKdVMoTiv5Xj21NGtfz3rwjlTYUSQ2/kdVGPnn5j0LV0k3cfz8o7LYFcw4+Tn2RllrDKKq3htTJwMBnpRWDKZkp+p74W92qnj4LiLO7+LuUK177wPV6TwBci87d7xjDpUKVf7kUsHWZMrtnTq1S8Y5rY1MwP73UVbz2H/j9qyRsOSMzFptZBZXhd83Lw8BH+EOPpo3F5fVvJg/OPThJ7Yz+aKai/qHZIBk1uIG85MYJgZBBwKw5My3ePOrTPXv989SqIli0xItN8a87bMAj1rufvcIWEoesniLDNg/CS77D5Y0ksKtPtGW5MafRAZBbs/p20jjRpyvXH7eNEAM4IZMHm6tQLkccB+4egQOQxd9fz9ZW7kFCFgQK4TfXRSKA==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(70586007)(70206006)(83380400001)(53546011)(4326008)(16526019)(2616005)(6666004)(31696002)(426003)(336012)(82960400001)(82310400004)(508600001)(316002)(356005)(86362001)(16576012)(36906005)(54906003)(110136005)(81166007)(186003)(26005)(2906002)(36860700001)(47076005)(31686004)(36756003)(40460700003)(7416002)(5660300002)(8936002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 19:30:53.2598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb7457e-b118-4d47-257c-08da0dcccfd6
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0007.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6391
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hans

On 3/24/22 12:47, Hans de Goede wrote:
> Fix the following warnings from "make htmldocs":
> 
> Documentation/ABI/testing/sysfs-class-firmware-attributes:130:
>   ERROR: Unexpected indentation.
>   ERROR: Unexpected indentation.
>   ERROR: Unexpected indentation.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../testing/sysfs-class-firmware-attributes   | 42 ++++++++++---------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 05820365f1ec..5356ff2ed6c8 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -246,9 +246,7 @@ Description:
>  					that is being referenced (e.g hdd0, hdd1 etc)
>  					This attribute defaults to device 0.
>  
> -		certificate:
> -		signature:
> -		save_signature:
> +		certificate, signature, save_signature:
>  					These attributes are used for certificate based authentication. This is
>  					used in conjunction with a signing server as an alternative to password
>  					based authentication.
> @@ -257,22 +255,27 @@ Description:
>  					The attributes can be displayed to check the stored value.
>  
>  					Some usage examples:
> -					Installing a certificate to enable feature:
> -						echo <supervisor password > authentication/Admin/current_password
> -						echo <signed certificate> > authentication/Admin/certificate
>  
> -					Updating the installed certificate:
> -						echo <signature> > authentication/Admin/signature
> -						echo <signed certificate> > authentication/Admin/certificate
> +						Installing a certificate to enable feature::
>  
> -					Removing the installed certificate:
> -						echo <signature> > authentication/Admin/signature
> -						echo '' > authentication/Admin/certificate
> +							echo "supervisor password" > authentication/Admin/current_password
> +							echo "signed certificate" > authentication/Admin/certificate
>  
> -					Changing a BIOS setting:
> -						echo <signature> > authentication/Admin/signature
> -						echo <save signature> > authentication/Admin/save_signature
> -						echo Enable > attribute/PasswordBeep/current_value
> +						Updating the installed certificate::
> +
> +							echo "signature" > authentication/Admin/signature
> +							echo "signed certificate" > authentication/Admin/certificate
> +
> +						Removing the installed certificate::
> +
> +							echo "signature" > authentication/Admin/signature
> +							echo "" > authentication/Admin/certificate
> +
> +						Changing a BIOS setting::
> +
> +							echo "signature" > authentication/Admin/signature
> +							echo "save signature" > authentication/Admin/save_signature
> +							echo Enable > attribute/PasswordBeep/current_value
>  
>  					You cannot enable certificate authentication if a supervisor password
>  					has not been set.
> @@ -288,9 +291,10 @@ Description:
>  		certificate_to_password:
>  					Write only attribute used to switch from certificate based authentication
>  					back to password based.
> -					Usage:
> -						echo <signature> > authentication/Admin/signature
> -						echo <password> > authentication/Admin/certificate_to_password
> +					Usage::
> +
> +						echo "signature" > authentication/Admin/signature
> +						echo "password" > authentication/Admin/certificate_to_password
>  
>  
>  What:		/sys/class/firmware-attributes/*/attributes/pending_reboot

Looks good!
Mark
