Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C452E1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiETBYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiETBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:24:10 -0400
Received: from sonic308-21.consmr.mail.sg3.yahoo.com (sonic308-21.consmr.mail.sg3.yahoo.com [106.10.241.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B32C133
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653009846; bh=SDmCMxGukSr+rhV2GcuJSjfvWe7jthiIZh9g31GHpxg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KIOhA+doJKV7xFUp0DOga2FFnoJGjxgyi8khYt0yYyxVpAIP6oArFDa9C6e9StXSsTFG5Tvj98E986HabZiqcx0nc4vC+0hsY9OJagYMEZp495ZlOnWZB4n30s/HKLJA06DWQ+CAWh+L8FH+dC0NNffs0VMq/H96rPulDCy5aiXqN/m52Cgu365rz07bbBsPP/61KP6SMBKn38QBXBLUrlwe/ADt+lBYiQMGQ19Io7axyRkF7JpnuAf+mF1cLMZXBZ98DD/U6/dNrPR3+tKCBRVrYgh7oPHe2LpeIWo3XEv6BfZA2mSaZgUTSQQzXk+S/tDSKeUnAwW/+/aS281m9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653009846; bh=GP3vk/lA+HtYa4aHcDLp46pZ0NXRf8gCM27cgdTuObI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a43bZCFxR70IA8IqknLDZstUnGCIXz7h2pqEix8kzEw05MOCh2HfFloiErM1R89Z6F0EqEIK4dr2uPop0862mWwdp0TzpDdbU2XuVO0EGa7CJ2zMvCEhFVrsNzuATJwOXloofbZoPLJrhmM5Os+fv6A9fPGbVTAxMT/mAt9pDxio06Rn/GsXHFKY4fYm1L8/UvvNuJoBqkF93JX0G8/il5onGsYyCwVFwkrm8sdpvnnSaEtxU0gYikYRZrk8Dr9ibYjjxzH8Gh2tmb3kopga/UFkftGtR+fm+XJjC3Mlav83n7WVdecyUKBAf7XHE+PQTWKUIwaubCZFaWwI9EfyZQ==
X-YMail-OSG: 5octqHcVM1lsavtS4_w.Mdx9C0fCQxSn8I4Paq4U33UpAdMRi1QJuNb1VdkPQOg
 oG0npniQgf50AuJv2reZQUm_.eTcCmLpr8e2BQmvf3jDgah1vfBI3mT7mwdiTnz5AsVYQwMGgPdH
 1J7HuYnvfhIqGeeJzFjf9QZYxjVrJNQVpoXjXVL0wGeJ4qnflXXaV.pI6mErmtnI18G0BtDk0bE1
 YL0pnfRBqqAzPIazpkd1Y9QwdQSa6qW6MY_EDo0DYMqZk5qRzN4tr5aMszOx_feqqxxf_8YSIN_8
 JKbb8z1Gt.wnQlFZVb5N5O7dN0RpZz6dDbJ16xEtkEE0hDK6f9fkDRQsZelDkuFdhIfRCm3eVCoz
 SBgKoHCzGSqxPEhx8M4EtC5qJOGIHnLlmUUWYDpxw5Fx4ZUULqvSSgD1AvVnVIJgU0UqKnOo7C_a
 lazZvL7fCwQ1PDsZqge2TjrmjDD_GLWNs.o7pmqNDthYeWC7pzoVfRsZY319qoXna9S4uMdFh3B9
 xiqoCJGTzmOkdK0WooZ0UTtw0LhWP.2Hfg11hWCTYkYm.naDULmrXmeCghY0niGfGmTCK0epMXnT
 TVhYgY49RhovRzRbuvxz6FnCQnJyLVVndZhHOX0UMt_WtkmrLgMuVAEIFh1RRWk7ReHoZkXlvxPH
 8zKPaA6PHOztpajh_Yys7oszePmJjCtD3Dbt4tpL1gHUVFNGLdjlHg9jZrUKYJ7Gxc.2eio.WaPw
 c67M1s0WtUZrFTLqI4vLZ7uDwtPQk9gu3wRtQMh4q_QkJbiAXz3mht7RsdTPPK7wBMvR_iZuzpLG
 5jQcsd8bSjVq7ED4baAQHBy7XJrejPDySmVSA9IgcWMijJVxNE6ph07esZu52_gg9nexcPR4Wmdt
 TrLTWDwjlFtADjI8TKSTdvnGJlTYbIV.mv9Ssrr8M_k2d8To59jcipKp492oH9e2me0btxRNkVzJ
 p_0yivx_ispVrdZBE_wtTqiR4dRvpq0OWt4Jvsgd_4kLpWVxVZL9BATJZ1o1SwUUocpWOmjncJuc
 jF.j0wl5XOtE.DrsvV6s2mkbBnEMJX80eYE65qAsFi8kFJh730TI_r9KyxQ9TPYWmVovobvpiOdi
 _dXklQDc2aeQ81xK6bW.Y4k09UBxM6cChQoCSru1IalcqQSeubfvxyFgsMC6bkQbuhTkNBqsrTln
 Upx8Su_yrvnXZKBfFpxl3pxfWPQkQpCrG7XMIAa5IwwmF_.Ra6ORXCQz.2tdpZHMO4aU8YACwIuI
 GMHfslypvYZfqEC2ZcdeeIDWs7QdG5krcB_CBREabPsDfrpI0x.nwYY6Ow.OX.1QD59XdSERP6iP
 z_dea1Nty7yyk1Hvrj2BVdUhtHK.4GQvd.FYFfBKRK2v_6bAoDmaGzB3UvpP6dnnnlxDNokpAZWn
 9uP8p0baaFKiKzSmD.8BEbLEziW9qwlQmCzGgpSnyHCEt1cuN3zGnwSFQpHCjRp5W0Dzmvwf3mZL
 Sbs6oQv6ZMbHkyUywX3se3.B4ZrtTsJ8_jtvvlzo9Lz4.bUaLZk_gN_AJsmOXMivzLUT1UbWGx7I
 ZYeDKspzWxfebkJGDoSTLBlKcHJNDLOqoeXMw8ERwiXVbGuiCs2kf3cDmaTCakyslvIp.wpE7IHL
 h8EIbSMzdgIWBw.NtAMft8cR2WwsWHkdAtLfiv270miPWlnwBrjLLPeIf5gdAuVPzT57bPW3hygU
 0kbrHY89n5z4vqjE9vJF9UYuh7W_70ggAxbL4Ttyo..4k6qk4Hf2GIvCyqVHTvRTAFEShm39tK4l
 nMfyJt2xyEWTFYuOwSh7vYkbE6IoroScKpX4dCWDyei.BIR8P6GnsTCd9XjW1GtN5Gz9Walm_1KQ
 e5D7vkmpq8BVDoUqN558jGTis2nqJGEkiKIDRILAqJ68yMeeaz4aodUjM.k.QdfPCK6TgtJ.y7IL
 51z622HFXnpuAaWlxfrJr10FANJ0_bFEDD2Hv1fAiFLg3ooJGPkpHLMbII8MBX2IvQlWhOpIpzq7
 Wz3ZA.aNwzdqzfjV6XiR9UjNXelHxmvomyNiGxxUt6YE8yUtt2_G_Jm2Scct4URBqurnEpm42dN2
 cZ0QdM8RO1zEFSR6D7rQiP3_ZEduxWmZjxYtxkJCT796nC3NWqSaMYCQKPuX019GwggW1eahMTgt
 1s94WyW_DHpMkzq6UFuUfkMXrSbM4oB.FbP25a9zp0EA1JbWWl_QBGr6S6Ak4rgoYF0fWr32GOy5
 YiQa8Ynvgih82D3pIkqYPpNaiMdWYOe9nw.HHPNcECxR0wgECXohtRtoUPaV_etb5bjCZ.07tvh8
 XeFLFm7zEBgP_yzo-
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 01:24:06 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-zszfs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed26338487b586305d0fb596fb2fc915;
          Fri, 20 May 2022 01:24:01 +0000 (UTC)
Message-ID: <7e5ecca1-aef7-ce90-7797-7f8be3b55715@yahoo.com.tw>
Date:   Fri, 20 May 2022 09:23:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, y.oudjana@protonmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        sboyd@codeaurora.org
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
 <20220519074112.25600-3-ae40515@yahoo.com.tw>
 <1652965539.974526.1359566.nullmailer@robh.at.kernel.org>
From:   Alec Su <ae40515@yahoo.com.tw>
In-Reply-To: <1652965539.974526.1359566.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/19 21:05, Rob Herring wrote:
> On Thu, 19 May 2022 07:41:12 +0000, Alec Su wrote:
>> Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
>> Snapdragon 821 SoC.
>>
>> Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> /: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
> 	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
> 	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
> 	arch/arm64/boot/dts/qcom/sm8150-hdk.dtb
> 	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dtb
> 	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb
> 	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb
> 	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
> 	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
> 	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb
> 	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb
> 	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb
> 	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb
> 	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
> 

I checked the full log. These warnings seem not the new warning caused
by the patch series. Look like these device trees are trying to match
with each of the compatible strings in qcom.yaml.
