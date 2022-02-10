Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771984B0EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbiBJNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:33:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbiBJNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:33:58 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E8C53;
        Thu, 10 Feb 2022 05:33:58 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 174772223A;
        Thu, 10 Feb 2022 14:33:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644500037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4J9FNtfm4H/Vg71/QaYcfYokCooPLvGFhwoek79uZ4=;
        b=tBW2U+BezYR7cRv34ugVojO8BVegO4GvsvIVx96sgpfvYpEg7+FhV4za3XE4aUorURukY+
        zoxMZzMaaDomROmP5OQ1mN2xstEe5d9y7ajPDXVSusFXS6dmhUiqwfNeD7h1ivmip8Y4s4
        qXduz6AcEor7KH7607j0ios1t0rY5No=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 14:33:57 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     Tudor.Ambarus@microchip.com, Manohar.Puri@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org
Subject: Re: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
In-Reply-To: <CO1PR11MB4865B76B9B26EE938E3E67CE922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <42662481-51a4-2a4b-e39b-d3b8401cbb2c@microchip.com>
 <20220210123704.477826-1-michael@walle.cc>
 <CO1PR11MB4865B76B9B26EE938E3E67CE922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <51e33e946b096c903b0cacb5681fc6f1@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-10 14:02, schrieb Kavyasree.Kotagiri@microchip.com:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi,
>> 
>> >  arch/arm/boot/dts/Makefile            |   2 +
>> >  arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
>> >  arch/arm/boot/dts/lan966x_pcb8291.dts |  61 +++++++
>> 
>> Please rename this to lan966x-pcb8921.dts. All (most?) of the device
>> tree files use the dash as a seperator between the SoC and the board.
>> 
> Ok, I will change in my v6.
> Please have a look at my v5 patch where I already addressed all the
> node naming changes.

My comments besides the renaming still apply.

-michael
