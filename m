Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAE4EAEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiC2Npy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiC2Npw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:45:52 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.180.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322227B22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:44:06 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 02120520C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:44:06 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZC8jn5xWJdx86ZC8jngqJm; Tue, 29 Mar 2022 08:44:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=akaWXAqGWszlSvuzQwGx8SWFkb7kshiZQC5A7fM3fWc=; b=iUaXWVgqnFLNqxftG1p4L/1jOT
        MVQZPIBVDgBZckh1q1WTVtYw45SZ1t6MSyoEzlBK2Rwa8F6BjCziQN+aLdPO+635XOb3y33+VM7V+
        QH05NrDci2nEoiX2k6A8qgmdQXYAqAHIExxYwOVCYbaN6MWshIJ04Axioi4H+ya0dYrEzCS6pWZXQ
        8fXjMov90e4E6U47lPXsxIsf9RqFJP6xfm022b5v4lsh4zDS4LltWqcigrfUTOyu8Q1DkB0agL+Sb
        2q/TdfkeOMtGJnXbcugxxSYvclQXT1DfBx02ursU3OfP4UuMDQ2srRmbjKJMPIIe9kRzvnZMqa1+f
        bN5njLQQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54540)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZC8j-00303a-Ea; Tue, 29 Mar 2022 13:44:05 +0000
Message-ID: <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
Date:   Tue, 29 Mar 2022 06:44:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-2-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
In-Reply-To: <20220327121404.1702631-2-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nZC8j-00303a-Ea
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54540
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 05:14, Eugene Shalygin wrote:
> We need to keep some more information about the current board than just
> the sensors set, and with more boards to add the dmi id array grows
> quickly. Our probe code is always the same so let's switch to a custom
> test code and a custom board info array. That allows us to omit board
> vendor string (ASUS uses two strings that differ in case) in the board
> info and use case-insensitive comparison, and also do not duplicate
> sensor definitions for such board variants as " (WI-FI)" when sensors
> are identical to the base variant.
> 
> Also saves a quarter of the module size by replacing big dmi_system_id
> structs with smaller ones.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>   drivers/hwmon/asus-ec-sensors.c | 209 ++++++++++++++++++--------------
>   1 file changed, 119 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index b5cf0136360c..7e28fc62f717 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -54,8 +54,7 @@ static char *mutex_path_override;
>   /* ACPI mutex for locking access to the EC for the firmware */
>   #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
>   
> -/* There are two variants of the vendor spelling */
> -#define VENDOR_ASUS_UPPER_CASE	"ASUSTeK COMPUTER INC."
> +#define MAX_IDENTICAL_BOARD_VARIATIONS	2
>   
>   typedef union {
>   	u32 value;
> @@ -164,68 +163,88 @@ static const struct ec_sensor_info known_ec_sensors[] = {
>   	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
>   #define SENSOR_SET_TEMP_WATER (SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT)
>   
> -#define DMI_EXACT_MATCH_BOARD(vendor, name, sensors) {                         \
> -	.matches = {                                                           \
> -		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, vendor),                     \
> -		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),                         \
> -	},                                                                     \
> -	.driver_data = (void *)(sensors), \
> -}
> +struct ec_board_info {
> +	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
> +	unsigned long sensors;
> +};
>   
> -static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "PRIME X570-PRO",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> -		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> -			      "ROG CROSSHAIR VIII DARK HERO",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> -		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> -			      "ROG CROSSHAIR VIII FORMULA",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> -			      "ROG CROSSHAIR VIII HERO (WI-FI)",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> -			      "ROG CROSSHAIR VIII IMPACT",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> -		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
> -		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> -		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
> -		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
> -	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
> -		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> +static const struct ec_board_info board_info[] __initconst = {
> +	{
> +		.board_names = {"PRIME X570-PRO"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
> +	},
> +	{
> +		.board_names = {"Pro WS X570-ACE"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR |
> +			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> +			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> +			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> +			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {
> +			"ROG CROSSHAIR VIII HERO",
> +			"ROG CROSSHAIR VIII HERO (WI-FI)",
> +		},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR |
> +			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> +			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> +			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG STRIX B550-E GAMING"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_CPU_OPT,
> +	},
> +	{
> +		.board_names = {"ROG STRIX B550-I GAMING"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG STRIX X570-E GAMING"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
> +	{
> +		.board_names = {"ROG STRIX X570-F GAMING"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
> +	},
> +	{
> +		.board_names = {"ROG STRIX X570-I GAMING"},
> +		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> +			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +	},
>   	{}
>   };
>   
> @@ -235,7 +254,7 @@ struct ec_sensor {
>   };
>   
>   struct ec_sensors_data {
> -	unsigned long board_sensors;
> +	struct ec_board_info board_info;

Please explain why this needs to be the entire structure and not
just a pointer to it.

>   	struct ec_sensor *sensors;
>   	/* EC registers to read from */
>   	u16 *registers;
> @@ -245,8 +264,6 @@ struct ec_sensors_data {
>   	/* in jiffies */
>   	unsigned long last_updated;
>   	acpi_handle aml_mutex;
> -	/* number of board EC sensors */
> -	u8 nr_sensors;
>   	/*
>   	 * number of EC registers to read
>   	 * (sensor might span more than 1 register)
> @@ -281,12 +298,17 @@ get_sensor_info(const struct ec_sensors_data *state, int index)
>   	return &known_ec_sensors[state->sensors[index].info_index];
>   }
>   
> +static int sensor_count(const struct ec_board_info *board)
> +{
> +	return hweight_long(board->sensors);
> +}

This function is called several times. Does it really make sense, or is it
necessary, to re-calculate the number of sensors over and over again
instead of keeping it in ec->nr_sensors as before ? What are the benefits ?
Unless there is a good explanation I see that as unrelated and unnecessary
change.

> +
>   static int find_ec_sensor_index(const struct ec_sensors_data *ec,
>   				enum hwmon_sensor_types type, int channel)
>   {
>   	unsigned int i;
>   
> -	for (i = 0; i < ec->nr_sensors; i++) {
> +	for (i = 0; i < sensor_count(&ec->board_info); i++) {
>   		if (get_sensor_info(ec, i)->type == type) {
>   			if (channel == 0)
>   				return i;
> @@ -301,11 +323,6 @@ static int __init bank_compare(const void *a, const void *b)
>   	return *((const s8 *)a) - *((const s8 *)b);
>   }
>   
> -static int __init board_sensors_count(unsigned long sensors)
> -{
> -	return hweight_long(sensors);
> -}
> -
>   static void __init setup_sensor_data(struct ec_sensors_data *ec)
>   {
>   	struct ec_sensor *s = ec->sensors;
> @@ -316,8 +333,8 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
>   	ec->nr_banks = 0;
>   	ec->nr_registers = 0;
>   
> -	for_each_set_bit(i, &ec->board_sensors,
> -			  BITS_PER_TYPE(ec->board_sensors)) {
> +	for_each_set_bit(i, &ec->board_info.sensors,
> +			 BITS_PER_TYPE(ec->board_info.sensors)) {
>   		s->info_index = i;
>   		s->cached_value = 0;
>   		ec->nr_registers +=
> @@ -343,7 +360,7 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
>   	const struct ec_sensor_info *si;
>   	unsigned int i, j, register_idx = 0;
>   
> -	for (i = 0; i < ec->nr_sensors; ++i) {
> +	for (i = 0; i < sensor_count(&ec->board_info); ++i) {
>   		si = get_sensor_info(ec, i);
>   		for (j = 0; j < si->addr.components.size; ++j, ++register_idx) {
>   			ec->registers[register_idx] =
> @@ -457,9 +474,10 @@ static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
>   static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
>   {
>   	const struct ec_sensor_info *si;
> -	struct ec_sensor *s;
> +	struct ec_sensor *s, *sensor_end;
>   
> -	for (s = ec->sensors; s != ec->sensors + ec->nr_sensors; s++) {
> +	sensor_end = ec->sensors + sensor_count(&ec->board_info);
> +	for (s = ec->sensors; s != sensor_end; s++) {
>   		si = &known_ec_sensors[s->info_index];
>   		s->cached_value = get_sensor_value(si, data);
>   		data += si->addr.components.size;
> @@ -597,12 +615,24 @@ static struct hwmon_chip_info asus_ec_chip_info = {
>   	.ops = &asus_ec_hwmon_ops,
>   };
>   
> -static unsigned long __init get_board_sensors(void)
> +static const struct ec_board_info * __init get_board_info(void)
>   {
> -	const struct dmi_system_id *dmi_entry =
> -		dmi_first_match(asus_ec_dmi_table);
> +	const char *dmi_board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	const char *dmi_board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +	const struct ec_board_info *board;
> +
> +	if (!dmi_board_vendor || !dmi_board_name ||
> +	    strcasecmp(dmi_board_vendor, "ASUSTeK COMPUTER INC."))
> +		return NULL;
> +
> +	for (board = board_info; board->sensors; board++) {
> +		if (match_string(board->board_names,
> +				 MAX_IDENTICAL_BOARD_VARIATIONS,
> +				 dmi_board_name) >= 0)
> +			return board;
> +	}
>   
> -	return dmi_entry ? (unsigned long)dmi_entry->driver_data : 0;
> +	return NULL;
>   }
>   
>   static int __init asus_ec_probe(struct platform_device *pdev)
> @@ -610,17 +640,17 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   	const struct hwmon_channel_info **ptr_asus_ec_ci;
>   	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
>   	struct hwmon_channel_info *asus_ec_hwmon_chan;
> +	const struct ec_board_info *pboard_info;
>   	const struct hwmon_chip_info *chip_info;
>   	struct device *dev = &pdev->dev;
>   	struct ec_sensors_data *ec_data;
>   	const struct ec_sensor_info *si;
>   	enum hwmon_sensor_types type;
> -	unsigned long board_sensors;
>   	struct device *hwdev;
>   	unsigned int i;
>   
> -	board_sensors = get_board_sensors();
> -	if (!board_sensors)
> +	pboard_info = get_board_info();
> +	if (!pboard_info)
>   		return -ENODEV;
>   
>   	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
> @@ -629,9 +659,8 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	dev_set_drvdata(dev, ec_data);
> -	ec_data->board_sensors = board_sensors;
> -	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
> -	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
> +	ec_data->board_info = *pboard_info;
> +	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
>   					sizeof(struct ec_sensor), GFP_KERNEL);
>   
>   	setup_sensor_data(ec_data);
> @@ -647,7 +676,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   
>   	ec_data->aml_mutex = asus_hw_access_mutex(dev);
>   
> -	for (i = 0; i < ec_data->nr_sensors; ++i) {
> +	for (i = 0; i < sensor_count(&ec_data->board_info); ++i) {
>   		si = get_sensor_info(ec_data, i);
>   		if (!nr_count[si->type])
>   			++nr_types;
> @@ -681,7 +710,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   	}
>   
>   	dev_info(dev, "board has %d EC sensors that span %d registers",
> -		 ec_data->nr_sensors, ec_data->nr_registers);
> +		 sensor_count(&ec_data->board_info), ec_data->nr_registers);
>   
>   	hwdev = devm_hwmon_device_register_with_info(dev, "asusec",
>   						     ec_data, chip_info, NULL);
> @@ -703,8 +732,8 @@ static struct platform_driver asus_ec_sensors_platform_driver = {
>   	},
>   };
>   
> -MODULE_DEVICE_TABLE(dmi, asus_ec_dmi_table);
>   module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);
> +MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);

Why is MODULE_DEVICE_TABLE moved ?

>   
>   module_param_named(mutex_path, mutex_path_override, charp, 0);
>   MODULE_PARM_DESC(mutex_path,

