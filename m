Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73051DB52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442555AbiEFPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347628AbiEFPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:02:52 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6A5D5CE;
        Fri,  6 May 2022 07:59:08 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 84F631B00252;
        Fri,  6 May 2022 17:59:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1651849146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbT5IGtky0H4rQRh8Cp6duVvDTunMzK7mUfLU1XT12Q=;
        b=ZA1zp990cio1fHuBQ9fC/CLwgqo25zcAH+WW22ifRC7j2nOx/mcU21o+2eFjFToBZl3YYB
        Nnii/SpZz7WGRmRsj6Er3PDJhkAO8JZvXcUfgOp3bpj+V/V70v+0BnQO2EABlQiLVFvpYh
        AMiL+3lXQhTZ/phFbaiOBqlQdl1wk2hAfCHF0PN9BRDpGgU705coS6iIIozI7GwddzxmMq
        81KSAupC93VEwi9ga3b5E3onrsmvAjt0/5V/KaT8iSQ+9I06W8j4F7/Kaf9kT5ZRli25I5
        XgMHNQMAjPaEPTB6rd7QsDWS/jJh0y1ZGOTtSTiG7psP/yWEYt9Zuv1iZCnyXw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 293F8634C91;
        Fri,  6 May 2022 17:59:06 +0300 (EEST)
Date:   Fri, 6 May 2022 17:59:06 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: ov5675: add device-tree support
Message-ID: <YnU3umQnJxvYFmCg@valkosipuli.retiisi.eu>
References: <20220504135543.59522-1-foss+kernel@0leil.net>
 <20220504135543.59522-2-foss+kernel@0leil.net>
 <20220505074725.4aabembd4uh4tt23@uno.localdomain>
 <YnOKuGqQ74rGUz6q@valkosipuli.retiisi.eu>
 <1344ed86-1505-a1af-1671-67106a4b9cf7@theobroma-systems.com>
 <20220506144300.nv3lqogpkir3i7fz@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506144300.nv3lqogpkir3i7fz@uno.localdomain>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1651849146; a=rsa-sha256;
        cv=none;
        b=r7V0iWsvz7F/pm/x1tWejtH6MaAyyOlX+c5HeCcAurpqigfnSy10qXT4xmpbPSgxnlwXHf
        oCOkN7+QeKuJaYq6DaNoYZmicXau/Hacmx8ZWwRaRQiTb3ieUteJQFnPoR+3dukvSiOUgI
        TbOTjqqM8CkEnE9VcyTQ5n31OtBj6foObfTZhXAY/bV3IKFV1hqy15+b5QQXhmXy80EVzL
        8uPCjrtaePG5t2x2t54BDCYfgZMNuw25IMWH/PNGXMvOTXrDhVRacD4sUJz4PzDifEKqH4
        8BXeNBUAepkKf9/7rsIfxJson0JemVNXm6pjCfVOzQevFDGeyOTBPVmeUHSRHA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1651849146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbT5IGtky0H4rQRh8Cp6duVvDTunMzK7mUfLU1XT12Q=;
        b=uAsp9WyJrf5qEO97HiEWR8T2oJNtC7D4sAJNl0JvL50ILDoY89whjuuZX4rAGUTRzvOJPY
        FTTX9TAobCeRgLFzfLje3gSqr3JeXO92uYPucku+uNI+Jc3MSwEDzyLzVl5bR2f7/6cYfn
        SFDByxt1OIQHwK9ReeIBYxnb6PMxcRULwvVd0vUTNw5GR0E5Vh0bXOvS4zDjJttcl3FtUy
        Ch2t39+MUPGdIPCmP0SpCckbgdFU0v1p54uY5u212tBt+0QkV5W3ZPScVzJcezpF7QGazO
        EcnaDMQwuJnItK74lXl7rcMB0Zn+KOj7oNvbAr+CoCGofwuhShw9AgphOwoAog==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Fri, May 06, 2022 at 04:43:00PM +0200, Jacopo Mondi wrote:
> My understanding is that "clock-frequency" is
> an ACPI leftover that has been brought into some DT bindings as an
> historical mistake. OF can work well with the common clock framework,
> there's no need to introduce a property for the same purpose.

The other way around actually. It was first used on DT but it's no longer
the perferred way to set the frequency there. On ACPI it simply indicates
the frequency without an ability to set it.

-- 
Sakari Ailus
