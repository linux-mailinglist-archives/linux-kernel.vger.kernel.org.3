Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0D4C87D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiCAJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiCAJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:28:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A064FD28
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:27:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so19403312wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=boeILy2K/ZR+dYqXIjEiMAGmwgby5KgaRmCA/l92Lk0=;
        b=j/ppsux6FlyovatN+GmIjaDzzPQ0WdsMBo2jJyAfeOehNlOov5C2TSBpqTxBB9w9BG
         zKRW9QeS17LXySEX/FdI4+XmoO/NtI4H/vuWu2wRfwXu4RoERvIX6078oNiceC2pP92D
         xiQtE8rTUlPf6rI9borSflKSR3TtpfRtTNTLqwN3xIhP+pgizGfEdGEWCezSxwC/4Mqv
         04+085ZJU7VqS3y45XtzkCwStIS/aUZKekJcS5t+oS0ANaioDnY8r2NSvGFK/ATisPa4
         WxEPo+NmXu/WmuZh5IDoTJpZtBYKmTfX/Arhsw604mSQ8gT2WKgFFn892YnzdcuriEDQ
         zxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=boeILy2K/ZR+dYqXIjEiMAGmwgby5KgaRmCA/l92Lk0=;
        b=W49CWV76Vg4ClgGMVsoM9i/ujjEyjKqv63040GHfGBcfuB+f+MuOC5JgPpG3W+vWQx
         ksZh8RJRrIEpXllKAKg/86QszAy1x+crg3m4S+gV0TUGUUiJs87oMEgvdHm0r2/RsB4F
         +VoGwS54T6a7Gak22RhTuS2bh9YWx+etIDnnYBdt2mVVay3O4ueRAOfhOq3wab48SNp6
         RmOLw2XSoVdgWwaFGGUyX8ruupiN3rdUVzno9+imhdJ3PFuVqO5Rs5gKD25SBlXe4+Yy
         FjnNS5lz/PHqGMUB18rqLyEISc/tahX4T7/JwPQfVXxnRgNDZYwz/tpuf0Y4bgI+XJiM
         X3Pg==
X-Gm-Message-State: AOAM530kQaSN/8eIz1aSufIQg8doOuN1exwCjHKgMzUr1bL43MP538oH
        G4wuPHphCf60UCmqGXZTu1gGjg==
X-Google-Smtp-Source: ABdhPJylCL/GTxZSwlDDgkF/dTvgYXAR2/r9Rvu2YvEXWyfO7ayE09CzVC8PhrSMGXyPfKIZcmM0hw==
X-Received: by 2002:a05:6000:1e1d:b0:1ef:e163:928 with SMTP id bj29-20020a0560001e1d00b001efe1630928mr5141789wrb.221.1646126874766;
        Tue, 01 Mar 2022 01:27:54 -0800 (PST)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm12836177wrs.56.2022.03.01.01.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:27:54 -0800 (PST)
Message-ID: <c23fe6e7-879a-fab6-71ba-fcebdaf7ae37@baylibre.com>
Date:   Tue, 1 Mar 2022 10:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <1j8rtvxnkv.fsf@starbuckisacylon.baylibre.com>
 <d0da38f1-72c1-d111-2d0d-2bfa2faf1a1d@amlogic.com>
 <1jilsyvyz9.fsf@starbuckisacylon.baylibre.com>
 <0054cf2f-f09d-5b01-d6ca-0dc877a757c3@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <0054cf2f-f09d-5b01-d6ca-0dc877a757c3@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/2022 10:01, Yu Tu wrote:
> Hi Jerome,
> 
> On 2022/3/1 16:36, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>>
>> On Tue 01 Mar 2022 at 13:54, Yu Tu <yu.tu@amlogic.com> wrote:
>>
>>> Hi Jerome,
>>>
>>> On 2022/2/28 18:59, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Using the common Clock code to describe the UART baud rate
>>>>> clock makes it easier for the UART driver to be compatible
>>>>> with the baud rate requirements of the UART IP on different
>>>>> meson chips. Add Meson S4 SoC compatible.
>>>>>
>>>>> The test method:
>>>>> Start the console and run the following commands in turn:
>>>>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>>>>>
>>>>> Since most SoCs are too old, I was able to find all the platforms myself
>>>>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
>>>>> G12A and S4.
>>>> GXL based board are still very common an easy to come by.
>>>> I'm quite surprised that you are unable to test on this SoC family
>>> The fact of the matter is that the S4 is our end-2020 chip, the G12A is
>>> five years old, and the GXL is seven years old. If you must ask for a
>>> test, I will report this problem to the leadership to coordinate resources.
>>
>> The age of the SoC is irrelevant. SoCs don't get deprecated based on age
>> in mainline. It is not just GXL, same goes for meson8.
>>
>> These SoCs are actively used. Boards with these SoCs are still sold and
>> easily available. See the VIM1 or the Libretech boards.
>>
>> Breaking things for the the users of these SoCs is not acceptable.
>> So yes, looking at your series, I strongly recommend you do more tests.
>>
> You have a point there. Let's go back to the root of the problem. I aim to increase S4. The S4 uses 12MHZ to calculate baud. That's all.
> Change it to CCF as you suggested. The changes are so large that you ask to test all the chips.
> I also mentioned last time that using CCF would lead to a longer drive probe time and affect the board startup time. If this problem is not solved, can we reject the way you suggest using CCF?

I have a much simpler proposal (non-tested):

============><===================================================
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 45e00d928253..eda3fdad60d1 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -76,6 +76,12 @@
  #define AML_UART_POLL_USEC		5
  #define AML_UART_TIMEOUT_USEC		10000

+struct meson_uart_data {
+	struct clk	*clk_pclk;
+	struct clk	*clk_xtal;
+	struct clk	*clk_baud;
+};
+
  static struct uart_driver meson_uart_driver;

  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
@@ -293,16 +299,17 @@ static int meson_uart_startup(struct uart_port *port)

  static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
  {
+	struct meson_uart_data *private_data = port->private_data;
  	u32 val;

  	while (!meson_uart_tx_empty(port))
  		cpu_relax();

-	if (port->uartclk == 24000000) {
-		val = ((port->uartclk / 3) / baud) - 1;
+	if (clk_is_match(private_data->clk_baud, private_data->clk_xtal)) {
+		val = ((clk_get_rate(private_data->clk_baud) / 3) / baud) - 1;
  		val |= AML_UART_BAUD_XTAL;
  	} else {
-		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+		val = ((clk_get_rate(private_data->clk_baud) * 10 / (baud * 4) + 5) / 10) - 1;
  	}
  	val |= AML_UART_BAUD_USE;
  	writel(val, port->membase + AML_UART_REG5);
@@ -666,31 +673,26 @@ static inline struct clk *meson_uart_probe_clock(struct device *dev,
  }

  static int meson_uart_probe_clocks(struct platform_device *pdev,
-				   struct uart_port *port)
+				   struct meson_uart_data *private_data)
  {
-	struct clk *clk_xtal = NULL;
-	struct clk *clk_pclk = NULL;
-	struct clk *clk_baud = NULL;
-
-	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
-	if (IS_ERR(clk_pclk))
-		return PTR_ERR(clk_pclk);
+	private_data->clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
+	if (IS_ERR(private_data->clk_pclk))
+		return PTR_ERR(private_data->clk_pclk);

-	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
-	if (IS_ERR(clk_xtal))
-		return PTR_ERR(clk_xtal);
+	private_data->clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
+	if (IS_ERR(private_data->clk_xtal))
+		return PTR_ERR(private_data->clk_xtal);

-	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
-	if (IS_ERR(clk_baud))
-		return PTR_ERR(clk_baud);
-
-	port->uartclk = clk_get_rate(clk_baud);
+	private_data->clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
+	if (IS_ERR(private_data->clk_baud))
+		return PTR_ERR(private_data->clk_baud);

  	return 0;
  }

  static int meson_uart_probe(struct platform_device *pdev)
  {
+	struct meson_uart_data *private_data;
  	struct resource *res_mem;
  	struct uart_port *port;
  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
@@ -714,6 +716,11 @@ static int meson_uart_probe(struct platform_device *pdev)
  	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
  		return -EINVAL;

+	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
+				    GFP_KERNEL);
+	if (!private_data)
+		return -ENOMEM;
+
  	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  	if (!res_mem)
  		return -ENODEV;
@@ -733,7 +740,7 @@ static int meson_uart_probe(struct platform_device *pdev)
  	if (!port)
  		return -ENOMEM;

-	ret = meson_uart_probe_clocks(pdev, port);
+	ret = meson_uart_probe_clocks(pdev, private_data);
  	if (ret)
  		return ret;

@@ -749,6 +756,7 @@ static int meson_uart_probe(struct platform_device *pdev)
  	port->x_char = 0;
  	port->ops = &meson_uart_ops;
  	port->fifosize = fifosize;
+	port->private_data = private_data;

  	meson_ports[pdev->id] = port;
  	platform_set_drvdata(pdev, port);
============><===================================================

Neil

>>>>
>>>>>
>>>>> Yu Tu (6):
>>>>>     tty: serial: meson: Move request the register region to probe
>>>>>     tty: serial: meson: Use devm_ioremap_resource to get register mapped
>>>>>       memory
>>>>>     tty: serial: meson: Describes the calculation of the UART baud rate
>>>>>       clock using a clock frame
>>>>>     tty: serial: meson: Make some bit of the REG5 register writable
>>>>>     tty: serial: meson: The system stuck when you run the stty command on
>>>>>       the console to change the baud rate
>>>>>     tty: serial: meson: Added S4 SOC compatibility
>>>>>
>>>>> V6 -> V7: To solve the system stuck when you run the stty command on
>>>>> the console to change the baud rate.
>>>>> V5 -> V6: Change error format as discussed in the email.
>>>>> V4 -> V5: Change error format.
>>>>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>>>>> in the email.
>>>>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
>>>>> the DTS before it can be deleted
>>>>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
>>>>> discussed in the email
>>>>>
>>>>> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
>>>>>
>>>>>    drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>>>>>    1 file changed, 154 insertions(+), 67 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8
>>>>
>>

