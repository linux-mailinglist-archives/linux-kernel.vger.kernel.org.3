Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC804C46A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiBYNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiBYNgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:36:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81F1DB3D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:35:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75EA1B830B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F92BC340E7;
        Fri, 25 Feb 2022 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645796132;
        bh=3ru70PNu1fPmDnbfvhLX0F5rEPgIzqF/E/iw7W1PbzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aUrsnQPrVv9inRpfjCjXSAiIPH/XQ6VpylpiNO8BxEBCyKHiyPpSxVUXFCE1yD74S
         Laoyt2Tf3xDNWAuvR54FqzSft1MMmMRe4kOvWh+pdcLfNoLRLqbwQJMi7/ZdsC5920
         +H1Dq1pLGlsGZ9TFe2rTJV4ix2Nqn9FFoqpZNtB1F6Y66cBkklp2H3dB0HKQjgSboh
         JZInjAQt74SNbsIzW3nOR7ugyURlirZ/mJ7bAX7XFfh011o8eX/JGFaWHyAh/Lona1
         s0QR+VBQVnbdp4ZC4sBJy3j56M2l4pC4eOeXSWzttLA7ELa1EkIlAbuk8P0vig+H8W
         PFhnSi31z2HfQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNakr-00AXGF-JE; Fri, 25 Feb 2022 13:35:29 +0000
MIME-Version: 1.0
Date:   Fri, 25 Feb 2022 13:35:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     cgel.zte@gmail.com
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, will@kernel.org
Subject: Re: [PATCH] KVM: arm64: Remove unneeded semicolon
In-Reply-To: <20220223092750.1934130-1-deng.changcheng@zte.com.cn>
References: <20220223092750.1934130-1-deng.changcheng@zte.com.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c78a0a5af9e402b9638b4898f79b69e3@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cgel.zte@gmail.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, deng.changcheng@zte.com.cn, zealci@zte.com.cn
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-23 09:27, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./arch/arm64/kvm/psci.c: 379: 3-4: Unneeded semicolon
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  arch/arm64/kvm/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index 0a00ef250725..3b16dae4ab3d 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -376,7 +376,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu
> *vcpu, u32 minor)
>  				ret = 0;
>  			}
>  			break;
> -		};
> +		}
>  		fallthrough;
>  	default:
>  		return kvm_psci_0_2_call(vcpu);

Thanks for that. You may want to check why your script didn't pick
this particular instance of the same defect:

diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index b43adf7dc29f..0d48d1e7291d 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -438,7 +438,7 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
  		return kvm_psci_0_1_call(vcpu);
  	default:
  		return -EINVAL;
-	};
+	}
  }

  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)

I'll squash it into you patch and push it into -next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
