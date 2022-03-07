Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F374D0C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbiCGXbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiCGXbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:31:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EA3A734;
        Mon,  7 Mar 2022 15:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D877B8174B;
        Mon,  7 Mar 2022 23:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FE3C340E9;
        Mon,  7 Mar 2022 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646695808;
        bh=xVnmU8N4F52iJ2qBcVlwuT2W+P6GcxqA0v7auOO+e14=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uOhY4UMq+E9XMXgKGLPJHmWKaFWSFRTlRzimtHRNghZWCrE9V6lnWEtTCcDPZYQBo
         sATHM0BZ/yXkR527/o9r7Cg/RlFulGPkVAY9esemOmVxWFIVjgi4eVjn6HBguTRIyX
         pNRimXywaNCOHFupdSqGDn5x8HLeSLfbHs/bRcUri6m9KihVVAR5IrQBV0ZtWyWZIM
         Lsnbc8eFyZ7BSQSSI0pi2SN3f0tU5D8hFzoNrtEDvvi7Dfp/7PTt5irpY+nuzR0dqw
         /raFjYlvQFBJmdWDfkKLsjiZ0fq2TpakujPf27IIUW6MJlHwFZ5wKsDlZaA4oFu+Sa
         Sfgb4jDWjGwsw==
Date:   Mon, 7 Mar 2022 15:30:07 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen
 hypervisor
In-Reply-To: <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
Message-ID: <alpine.DEB.2.22.394.2203071529380.3261@ubuntu-linux-20-04-desktop>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com> <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1674660485-1646695809=:3261"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1674660485-1646695809=:3261
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Mar 2022, Oleksii Moisieiev wrote:
> Xen is an open source stage-1 hypervisor.
                        ^ type-1

> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

With the minor correction:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 294093d45a23..0d10a55df910 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1360,6 +1360,8 @@ patternProperties:
>      description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
>    "^x-powers,.*":
>      description: X-Powers
> +  "^xen,.*":
> +    description: Xen Hypervisor
>    "^xes,.*":
>      description: Extreme Engineering Solutions (X-ES)
>    "^xiaomi,.*":
> -- 
> 2.27.0
> 
--8323329-1674660485-1646695809=:3261--
