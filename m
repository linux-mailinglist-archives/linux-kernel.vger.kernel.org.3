Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB0520A43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiEJAiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiEJAiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:38:04 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBED2AF612;
        Mon,  9 May 2022 17:33:57 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249MLQAk006420;
        Tue, 10 May 2022 00:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pps0720;
 bh=ioAI3ToVnDGORtMvoHII/m9QFAic51VEYz4dbe8gUHc=;
 b=lEMqnmW0mWVPZI1FXuZldSthA/vjIf8ft5gM9O3OgxAj57WYtgcTnLPWToHp98iNXlNY
 74wveliv/IdNfp0XKdJ+zrRmHaaLu22AzmntW4h8RQQRRqL5rS1EwEoTR4wzhwmjwzMO
 Wad1RRLTgjndDOm1W4SOWIc/ScS3JA8QrfT7St1bTAhaXBTxvbUQcR+HXDXvjm7cjw7S
 E7pOY1iQWC13I9lMwka1XRz6jlliXjn4n1eI5wrR0B44bdPFlEEansU8uVQPDXHpBjKG
 79NSteey1JTfy0dnpq1uOSCDWlK8RQWAJCLCCOYNvFOWiRUfyBpz+GJwKfojIEqnVmd2 eA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fy4m1vvv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 00:33:42 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id D2A7565;
        Tue, 10 May 2022 00:33:40 +0000 (UTC)
Received: from perchik.americas.hpqcorp.net (perchik.americas.hpqcorp.net [10.33.142.136])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1758237;
        Tue, 10 May 2022 00:33:39 +0000 (UTC)
Date:   Mon, 9 May 2022 18:33:39 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ionut_n2001@yahoo.com
Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Message-ID: <20220510003339.GA2788@perchik.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20220509163304.86-1-mario.limonciello@amd.com>
 <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: 8U-LK90bxCsYOwvnoRYgccXxVQrLoaPI
X-Proofpoint-ORIG-GUID: 8U-LK90bxCsYOwvnoRYgccXxVQrLoaPI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_06,2022-05-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205100000
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:55:54PM -0700, Guenter Roeck wrote:
> On 5/9/22 09:33, Mario Limonciello wrote:
> > If watchdog hardware has been disabled, currently the kernel driver
> > will show at err level during probe:
> > 
> > "Watchdog hardware is disabled"
> > 
> > This is unnecessarily verbose as there is already a -ENODEV returned.
> > Lower the level to debug.
> 
> Is it ? Without this message, a user may try to load the driver,
> get an error message, and have no idea why the driver was not
> enabled even though the hardware exists. If anything , -ENODEV
> is less than perfect. Unfortunately there does not seem to be
> a better error code, or at least I don't see one.
> 
> Guenter

Coincidentally, I was looking at this code on Friday.

Some HPE Proliant servers are disabling the AMD WDT in BIOS.  However,
sp5100_tco was still getting configured.  It was the lack of
"Watchdog hardware is disabled" message that helped clue us into
what was going on (Linux is enabling the WDT anyway.)

So, I liked that this message exists.

I'll send an RFC patch for this other issue as it orthogonal.
But just wanted to point out the message is useful.


> 
> > 
> > Reported-by: ionut_n2001@yahoo.com
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215762
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/watchdog/sp5100_tco.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> > index 86ffb58fbc85..e51ecbd5c8b7 100644
> > --- a/drivers/watchdog/sp5100_tco.c
> > +++ b/drivers/watchdog/sp5100_tco.c
> > @@ -286,7 +286,7 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
> >   	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
> >   	if (val & SP5100_WDT_DISABLED) {
> > -		dev_err(dev, "Watchdog hardware is disabled\n");
> > +		dev_dbg(dev, "Watchdog hardware is disabled\n");
> >   		return -ENODEV;
> >   	}

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
