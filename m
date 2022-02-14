Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBC4B40A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiBNEVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:21:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBNEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:21:05 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60624F443;
        Sun, 13 Feb 2022 20:20:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F2E743200E51;
        Sun, 13 Feb 2022 23:20:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Feb 2022 23:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=FNdavk6AjBVF3M
        6f8Rc393UvIIdwHUCZdblJizpLtLw=; b=JBYUtyIUaHTTKpovEQf5yQk3C2AIlx
        4VM1z4XBoej2rFH+B0D0c58Zh9uzc68DIYL28iX4zAXaebkRgtO00VNfWFif+R0w
        UJIUc42xYVpFsA8SiJ572WbfGFM4h3dDECxKbxqyoYVOh+mi8WJBIfG7sMNBNm1B
        qtRf4FANjdbZowHGD4dsR1Vf127k4RY98O1OsBCqcngTZKQRTmoPTZ35gevW9ueV
        2nmVqHv1T7bqVjHiBbQ0rZotU5YuBPuN/BPPmJACWBwKDV4GRd2P7LbkBN9hfaMR
        +TuEThbMcFa9Q86heI1L+2I2E70D43TWhluCPE7LMycDdMRyQP6pDA7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=FNdavk6AjBVF3M6f8Rc393UvIIdwHUCZdblJizpLt
        Lw=; b=Wtm1i0p8n7m8lDaml8hNKfC3z7JMwP2YtrcQlyjW/yTm2EKgCwvPklhbk
        H8BzstMDVvESyFb2WSsRHjCZ58Cqm7v240ak+SAGb5vfvmTsz9ulHa+3PLC6JAmQ
        g6faASl7b/yACemlwotwJawBEc24nuIXlcy38m7VfM3m3r/7EKzlcFONJ7CiMaVc
        YCJBRjoBOO3Bt2OhOJwEPmMta8BaO2Lzuahj2DFMiduS8SAiaiD2ctaO8j2hgcM8
        M62RESfi2G4Ak4MzUZiynx8D43pnB3x4pEmqy5n5PlQKEFe5oZlIhHS1Oa19x6n/
        RJYaOulHea9kWFqHl6rXfAMPGoaXg==
X-ME-Sender: <xms:pdgJYkUIxMfxyLqy5goXEJcg_JHwCXjNXILhLGP7DBx_LDbOB6VNGA>
    <xme:pdgJYomfd-tfbPivWh8XTZ1zR70xSHTO3YuQ1ykuBBQ6oJF4Fhcf477rbPDFeAtG9
    kVGvNUH9lxFlz7sIw>
X-ME-Received: <xmr:pdgJYoZb8JKD0UX34QLJJ6k9GqPTahIWbuSTSK7wunVa_aXR49sxZXSRZ7xU85TcN6o5nIbPw23-FzX3qOJYBNh5tgJ0proVJ5wH5uY-i4TmFXvbvm3GHW19gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:pdgJYjXI_FprD_iSqxtMJGEIx-NZ3DI-n_b45Gy3pU3Ltmo8sDEaTQ>
    <xmx:pdgJYumgoJyk52lkEI-pWJ1IAZVTPAvlnJeafjXBrLy48kqEV3dcXA>
    <xmx:pdgJYod1qOYfiFktSzuJ1IQ0QDtE9ORr5lhQd6PozAlOCtOlfVG43Q>
    <xmx:ptgJYvDTsJcxe42DpQ5WjkvQdG2M5XaFhyU27ZV_MsIZQJjhE-MK2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Feb 2022 23:20:53 -0500 (EST)
Subject: Re: [PATCH 3/3] power: supply: Add a driver for Injoinic power bank
 ICs
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <x@xff.cz>
References: <20220129222424.45707-1-samuel@sholland.org>
 <20220129222424.45707-3-samuel@sholland.org>
 <20220211212218.j5r75tyvhirxis4z@mercury.elektranox.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8027f37b-3977-adaa-d2cf-d59ae243cc32@sholland.org>
Date:   Sun, 13 Feb 2022 22:20:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211212218.j5r75tyvhirxis4z@mercury.elektranox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/22 3:22 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Jan 29, 2022 at 04:24:24PM -0600, Samuel Holland wrote:
>> This driver supports several chip variants which all share the same I2C
>> register interface. Since the chip will turn off and become inaccessible
>> under conditions outside of software control (e.g. upon button press or
>> input voltage removal), some special handling is needed to delay the
>> initialization of the IC until it is accessible.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
> 
> Thanks, driver looks mostly good to me. Just two things:
> 
>> [...]
>> +static const struct power_supply_desc ip5xxx_charger_desc = {
>> +	.name			= "ip5xxx-charger",
>> +	.type			= POWER_SUPPLY_TYPE_BATTERY,
> 
> POWER_SUPPLY_TYPE_BATTERY is the wrong type for a charger.
> Considering the chips want 5V on the input side as far as
> I could see, a sensible type is POWER_SUPPLY_TYPE_USB.

The chip takes a 5V USB input, charges a battery, and then boosts the battery
voltage back up to 5V on the output side (or passes the input voltage, if
present, directly through to the output).

Currently only POWER_SUPPLY_PROP_ONLINE describes the output side of the chip.
All of the other properties here describe the battery. For example,
POWER_SUPPLY_PROP_VOLTAGE/CURRENT_NOW is the battery voltage/current, not the
output voltage/current. That doesn't match what I would expect from
POWER_SUPPLY_TYPE_USB.

Should there really be two separate power supplies, one for the battery of type
POWER_SUPPLY_TYPE_BATTERY, and a second one for the output side of type
POWER_SUPPLY_TYPE_USB, with the battery supplying the boost output stage? I'll
send v2 with this idea; please let me know what you think.

Since these two supplies would share the same device and OF node, how would I
link them together?

>> +	.properties		= ip5xxx_charger_properties,
>> +	.num_properties		= ARRAY_SIZE(ip5xxx_charger_properties),
>> +	.get_property		= ip5xxx_charger_get_property,
>> +	.set_property		= ip5xxx_charger_set_property,
>> +	.property_is_writeable	= ip5xxx_charger_property_is_writeable,
>> +};
>> +
>> +static const struct regmap_config ip5xxx_regmap_config = {
>> +	.reg_bits		= 8,
>> +	.val_bits		= 8,
>> +	.max_register		= IP5XXX_BATOCV_DAT1,
>> +};
>> +
>> +static int ip5xxx_power_probe(struct i2c_client *client)
>> +{
>> +	struct power_supply_config psy_cfg = {};
>> +	struct device *dev = &client->dev;
>> +	struct power_supply *psy;
>> +	struct ip5xxx *ip5xxx;
>> +
>> +	ip5xxx = devm_kzalloc(dev, sizeof(*ip5xxx), GFP_KERNEL);
> 
> if (!ip5xxx)
>     return -ENOMEM;

I'll fix this in v2.

Regards,
Samuel

> -- Sebastian
> 
>> +	ip5xxx->regmap = devm_regmap_init_i2c(client, &ip5xxx_regmap_config);
>> +	if (IS_ERR(ip5xxx->regmap))
>> +		return PTR_ERR(ip5xxx->regmap);
>> +
>> +	psy_cfg.of_node = dev->of_node;
>> +	psy_cfg.drv_data = ip5xxx;
>> +
>> +	psy = devm_power_supply_register(dev, &ip5xxx_charger_desc, &psy_cfg);
>> +	if (IS_ERR(psy))
>> +		return PTR_ERR(psy);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id ip5xxx_power_of_match[] = {
>> +	{ .compatible = "injoinic,ip5108" },
>> +	{ .compatible = "injoinic,ip5109" },
>> +	{ .compatible = "injoinic,ip5207" },
>> +	{ .compatible = "injoinic,ip5209" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
>> +
>> +static struct i2c_driver ip5xxx_power_driver = {
>> +	.probe_new	= ip5xxx_power_probe,
>> +	.driver		= {
>> +		.name		= "ip5xxx-power",
>> +		.of_match_table	= ip5xxx_power_of_match,
>> +	}
>> +};
>> +module_i2c_driver(ip5xxx_power_driver);
>> +
>> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
>> +MODULE_DESCRIPTION("Injoinic IP5xxx power bank IC driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.33.1
>>

