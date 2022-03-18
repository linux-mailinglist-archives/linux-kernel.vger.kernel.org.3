Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A394DE21A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCRUIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCRUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928F1FF208;
        Fri, 18 Mar 2022 13:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A27561BBC;
        Fri, 18 Mar 2022 20:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71FCC340E8;
        Fri, 18 Mar 2022 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647634014;
        bh=rSGGClOlzviu7qkL+I7KVERK4YDLJC8pYpOpKPqJJK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Npde3rcPofiP71idHFhci+gdU0jskf1HHFMqaTG7nUDPGVTBJXr2yRTeVK4LzrM2t
         0wbUMOyas0ySPe+bdTzesvXShUi1ThNq+5vaGCDjggKeJ8UeIzIvCnPfTIMefD01L7
         IrYOwetq+KSqKIm1DgUie/oJUvHkwCriV8hvVy2fAH+CJjU+9I9JVZS2fHBPVoSAQV
         ZxBSqycloVMcYWR5MTds5BjM7ARDme8pjS22ONBeDce16Spawtl87kU8rqJknreaKF
         CSMddJ4q5wVCkX05S8PHHOpFVfIP2oOhI9sa7OzG+0JFWh/EglGiuwKGy6mG46pxPu
         WzIuvJjRko+JQ==
Date:   Fri, 18 Mar 2022 20:06:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/2] regulator: mt6366: Add support for MT6366
 regulator
Message-ID: <YjTmWR3xNOpmztew@sirena.org.uk>
References: <20220317030402.24894-1-johnson.wang@mediatek.com>
 <20220317030402.24894-2-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ow9NmIg9bBeggGxL"
Content-Disposition: inline
In-Reply-To: <20220317030402.24894-2-johnson.wang@mediatek.com>
X-Cookie: How do I get HOME?
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ow9NmIg9bBeggGxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2022 at 11:04:01AM +0800, Johnson Wang wrote:
> The MT6366 is a regulator found on boards based on MediaTek MT8186 and
> probably other SoCs. It is a so called pmic and connects as a slave to
> SoC using SPI, wrapped inside the pmic-wrapper.

This doesn't build, please resend once the dependencies have been merged:

/mnt/kernel/drivers/regulator/mt6358-regulator.c:51:15: error: 'MT6358_BUCK_VCORE_SSHUB_ELR0' undeclared here (not in a function); did you mean 'MT6358_BUCK_VCORE_ELR0'?
   51 |   .vsel_reg = MT6358_BUCK_##vreg##_ELR0, \
      |               ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:508:2: note: in expansion of macro 'MT6358_BUCK'
  508 |  MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:53:17: error: 'MT6358_BUCK_VCORE_SSHUB_CON0' undeclared here (not in a function); did you mean 'MT6358_BUCK_VCORE_CON0'?
   53 |   .enable_reg = MT6358_BUCK_##vreg##_CON0, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:508:2: note: in expansion of macro 'MT6358_BUCK'
  508 |  MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:57:16: error: 'MT6358_BUCK_VCORE_SSHUB_DBG1' undeclared here (not in a function); did you mean 'MT6358_BUCK_VCORE_DBG1'?
   57 |  .status_reg = MT6358_BUCK_##vreg##_DBG1, \
      |                ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:508:2: note: in expansion of macro 'MT6358_BUCK'
  508 |  MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:593:7: error: 'MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1' undeclared here (not in a function); did you mean 'MT6358_ID_VSRAM_OTHERS_SSHUB'?
  593 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:103:15: note: in definition of macro 'MT6358_LDO1'
  103 |   .vsel_reg = vosel, \
      |               ^~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:105:17: error: 'MT6358_LDO_VSRAM_OTHERS_SSHUB_CON0' undeclared here (not in a function); did you mean 'MT6358_LDO_VSRAM_OTHERS_CON0'?
  105 |   .enable_reg = MT6358_LDO_##vreg##_CON0, \
      |                 ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:590:2: note: in expansion of macro 'MT6358_LDO1'
  590 |  MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:110:16: error: 'MT6358_LDO_VSRAM_OTHERS_SSHUB_DBG1' undeclared here (not in a function); did you mean 'MT6358_LDO_VSRAM_OTHERS_DBG1'?
  110 |  .status_reg = MT6358_LDO_##vreg##_DBG1, \
      |                ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:590:2: note: in expansion of macro 'MT6358_LDO1'
  590 |  MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:147:15: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  147 |   .vsel_reg = MT6358_BUCK_##vreg##_ELR0, \
      |               ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:147:15: note: (near initialization for 'mt6366_regulators[36].desc.vsel_reg')
  147 |   .vsel_reg = MT6358_BUCK_##vreg##_ELR0, \
      |               ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:147:15: error: initializer element is not constant
  147 |   .vsel_reg = MT6358_BUCK_##vreg##_ELR0, \
      |               ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:147:15: note: (near initialization for 'mt6366_regulators[36].desc.vsel_reg')
  147 |   .vsel_reg = MT6358_BUCK_##vreg##_ELR0, \
      |               ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:149:17: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  149 |   .enable_reg = MT6358_BUCK_##vreg##_CON0, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:149:17: note: (near initialization for 'mt6366_regulators[36].desc.enable_reg')
  149 |   .enable_reg = MT6358_BUCK_##vreg##_CON0, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:149:17: error: initializer element is not constant
  149 |   .enable_reg = MT6358_BUCK_##vreg##_CON0, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:149:17: note: (near initialization for 'mt6366_regulators[36].desc.enable_reg')
  149 |   .enable_reg = MT6358_BUCK_##vreg##_CON0, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:153:16: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  153 |  .status_reg = MT6358_BUCK_##vreg##_DBG1, \
      |                ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:153:16: note: (near initialization for 'mt6366_regulators[36].status_reg')
  153 |  .status_reg = MT6358_BUCK_##vreg##_DBG1, \
      |                ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:153:16: error: initializer element is not constant
  153 |  .status_reg = MT6358_BUCK_##vreg##_DBG1, \
      |                ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:153:16: note: (near initialization for 'mt6366_regulators[36].status_reg')
  153 |  .status_reg = MT6358_BUCK_##vreg##_DBG1, \
      |                ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:610:2: note: in expansion of macro 'MT6366_BUCK'
  610 |  MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:611:31: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  611 |       buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:155:17: note: in definition of macro 'MT6366_BUCK'
  155 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:611:31: note: (near initialization for 'mt6366_regulators[36].da_vsel_reg')
  611 |       buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:155:17: note: in definition of macro 'MT6366_BUCK'
  155 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:611:31: error: initializer element is not constant
  611 |       buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:155:17: note: in definition of macro 'MT6366_BUCK'
  155 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:611:31: note: (near initialization for 'mt6366_regulators[36].da_vsel_reg')
  611 |       buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:155:17: note: in definition of macro 'MT6366_BUCK'
  155 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:684:7: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  684 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:199:15: note: in definition of macro 'MT6366_LDO1'
  199 |   .vsel_reg = vosel, \
      |               ^~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:684:7: note: (near initialization for 'mt6366_regulators[37].desc.vsel_reg')
  684 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:199:15: note: in definition of macro 'MT6366_LDO1'
  199 |   .vsel_reg = vosel, \
      |               ^~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:684:7: error: initializer element is not constant
  684 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:199:15: note: in definition of macro 'MT6366_LDO1'
  199 |   .vsel_reg = vosel, \
      |               ^~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:684:7: note: (near initialization for 'mt6366_regulators[37].desc.vsel_reg')
  684 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:199:15: note: in definition of macro 'MT6366_LDO1'
  199 |   .vsel_reg = vosel, \
      |               ^~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:201:17: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  201 |   .enable_reg = MT6358_LDO_##vreg##_CON0, \
      |                 ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:201:17: note: (near initialization for 'mt6366_regulators[37].desc.enable_reg')
  201 |   .enable_reg = MT6358_LDO_##vreg##_CON0, \
      |                 ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:201:17: error: initializer element is not constant
  201 |   .enable_reg = MT6358_LDO_##vreg##_CON0, \
      |                 ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:201:17: note: (near initialization for 'mt6366_regulators[37].desc.enable_reg')
  201 |   .enable_reg = MT6358_LDO_##vreg##_CON0, \
      |                 ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:683:7: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  683 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:204:17: note: in definition of macro 'MT6366_LDO1'
  204 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:683:7: note: (near initialization for 'mt6366_regulators[37].da_vsel_reg')
  683 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:204:17: note: in definition of macro 'MT6366_LDO1'
  204 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:683:7: error: initializer element is not constant
  683 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:204:17: note: in definition of macro 'MT6366_LDO1'
  204 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:683:7: note: (near initialization for 'mt6366_regulators[37].da_vsel_reg')
  683 |       MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:204:17: note: in definition of macro 'MT6366_LDO1'
  204 |  .da_vsel_reg = _da_vsel_reg, \
      |                 ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:206:16: warning: initialization of 'unsigned int' from 'struct mt6358_regulator_info *' makes integer from pointer without a cast [-Wint-conversion]
  206 |  .status_reg = MT6358_LDO_##vreg##_DBG1, \
      |                ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:206:16: note: (near initialization for 'mt6366_regulators[37].status_reg')
  206 |  .status_reg = MT6358_LDO_##vreg##_DBG1, \
      |                ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:206:16: error: initializer element is not constant
  206 |  .status_reg = MT6358_LDO_##vreg##_DBG1, \
      |                ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:206:16: note: (near initialization for 'mt6366_regulators[37].status_reg')
  206 |  .status_reg = MT6358_LDO_##vreg##_DBG1, \
      |                ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c:681:2: note: in expansion of macro 'MT6366_LDO1'
  681 |  MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
      |  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/mt6358-regulator.c: In function 'mt6358_regulator_probe':
/mnt/kernel/drivers/regulator/mt6358-regulator.c:701:25: error: 'MT6366_CHIP_ID' undeclared (first use in this function); did you mean 'MT6397_CHIP_ID'?
  701 |  if (mt6397->chip_id == MT6366_CHIP_ID) {
      |                         ^~~~~~~~~~~~~~
      |                         MT6397_CHIP_ID
/mnt/kernel/drivers/regulator/mt6358-regulator.c:701:25: note: each undeclared identifier is reported only once for each function it appears in
/mnt/kernel/drivers/regulator/mt6358-regulator.c:701:22: warning: comparison between pointer and integer
  701 |  if (mt6397->chip_id == MT6366_CHIP_ID) {
      |                      ^~


--ow9NmIg9bBeggGxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI05lgACgkQJNaLcl1U
h9B/6gf/Y+634iYDE/CByhWCn2OxcMgMgLKyHFYVUPjJF2M6YE78HyOi2AGK8A1t
IjGD7gay4LDgNuUUHAXEf/q/g7rks1Fhr4h99fILg+aVXjsJxoRnFUTnviqKH8kb
kvGNxQ4Y44EiDCrCWh85dTl2XMVkqBW870NCGteY8QswisyDdV77tgn9jPpQnrZ6
77eojWk3bOEUT4tIYzVV/2PsuXsod5DdJq3R9a7YZK9PUJmt7ltITlyLME2wModn
APveEV6LYt2jgvAgyvKGXXTaDBnJtooQvqVKAjrenPsvxDz3H0YOBKd/I1JGxKdr
W2c1w2/0KuXPQ4rM2C0bDAGgVcksYw==
=MQ6X
-----END PGP SIGNATURE-----

--ow9NmIg9bBeggGxL--
