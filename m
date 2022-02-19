Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEC4BC8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiBSOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:47:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:47:11 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2481AB451;
        Sat, 19 Feb 2022 06:46:51 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n6so20726519qvk.13;
        Sat, 19 Feb 2022 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/AlPj1kV+uLNUE/ECwMMYFeLlrj+FpePAPwFYK2xO54=;
        b=XnjuTINubAEcq5CkYznGX6eNqDJmYGD/oMJKfbCX6n0D1Fz2T/4Sm6Go/Np6XPnbXY
         XSsCRSUwbPV3okyneIsgAZDqe7wMvNOQ7XQRyOdZxitagLjtqWx9nhlMtWFUiIcNQh4M
         9MIRv12bg19N96OayziAWfQ6FAZ7jnUeBWDo0qbRh57ldQizE9Jygy/PZbCkDXli1hu1
         PrtMo8SqUFmX53q52PHi0P2B23r94r6+IR8ykVbfEwMVu0qNmGNTpkfHUKiB+Vihde3F
         fG4H482wC9CQqvSv+y5woTPSbmFIp0aF2mkYhcyGeXIFoL6cYOKyzjH8cLZdXjXp5Rax
         xxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/AlPj1kV+uLNUE/ECwMMYFeLlrj+FpePAPwFYK2xO54=;
        b=1H8HcpkWremSuVFTb9JRp+i23WGlAzA6oBkjMTOlet2v1h6m6N4/zrnmQxAKkMZ0Ej
         DP2OW7DpRleO/Tgyq5qZqS7lwX624PLyTmPJsMOk7C1KpgbbAnXWVct8RN+1hKgDR4u9
         J+FMVgZFt34nhaL3RPQ0Wgv4tP+W3CjrEJoSQRlY6SE1pkrj97IoiSnkSCiqWC/aZ83l
         4uraWki4U6UiK4H7amnhj+XbBvAUyHuRBVeiJTF8N7tA63fyFtN6XzMv3gJ5Ay6grYk4
         Wf+S8upAz4Ct+92c8sR5zD8FM7tdBAqthVhz2gA0gFKJwlEotTKLcKduVo9z+A00mIQK
         ubyw==
X-Gm-Message-State: AOAM530PLx4hyBqtYHzjp1Lwq9XzI52rwldVUjnuMiMWnTYZfkZz7fRo
        yKU3lCGJKY9ZFl0RtHds6dY=
X-Google-Smtp-Source: ABdhPJxVJ7pelPX/bWLOEGkxuX9JA1u3hDbWAlWWIUXEB9hWXl7ly0qjIe7cRQCnr6QzhY2R+5fYBA==
X-Received: by 2002:ad4:4803:0:b0:42d:75b1:8c51 with SMTP id g3-20020ad44803000000b0042d75b18c51mr9609461qvy.63.1645282011061;
        Sat, 19 Feb 2022 06:46:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z23sm7066061qtn.40.2022.02.19.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:46:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:46:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] hwmon: (dell-smm) Add SMM interface documentation
Message-ID: <20220219144649.GA1032668@roeck-us.net>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-7-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-7-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:11:12PM +0100, Armin Wolf wrote:
> Document the SMM interface as requested by Pali Rohar.
> Since Dell does not offer any offical documentation
> regarding the SMM interface, the necessary information
> was extracted from the dell_smm_hwmon driver and other
> sources.
> 
> Suggested-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Pali Rohár <pali@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 180 +++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index cfaee682a245..12bba5fd1447 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -173,3 +173,183 @@ obtain the same information and to control the fan status. The ioctl
>  interface can be accessed from C programs or from shell using the
>  i8kctl utility. See the source file of ``i8kutils`` for more
>  information on how to use the ioctl interface.
> +
> +SMM Interface
> +-------------
> +
> +.. warning:: The SMM interface was reverse-engineered by trial-and-error
> +             since Dell did not provide any Documentation,
> +             please keep that in mind.
> +
> +The driver uses the SMM interface to send commands to the system BIOS.
> +This interface is normally used by Dell's 32-bit diagnostic program or
> +on newer notebook models by the buildin BIOS diagnostics.
> +The SMM is triggered by writing to the special ioports ``0xb2`` and ``0x84``,
> +and may cause short hangs when the BIOS code is taking too long to
> +execute.
> +
> +The SMM handler inside the system BIOS looks at the contents of the
> +``eax``, ``ebx``, ``ecx``, ``edx``, ``esi`` and ``edi`` registers.
> +Each register has a special purpose:
> +
> +=============== ==================================
> +Register        Purpose
> +=============== ==================================
> +eax             Holds the command code before SMM,
> +                holds the first result after SMM.
> +ebx             Holds the arguments.
> +ecx             Unknown, set to 0.
> +edx             Holds the second result after SMM.
> +esi             Unknown, set to 0.
> +edi             Unknown, set to 0.
> +=============== ==================================
> +
> +The SMM handler can signal a failure by either:
> +
> +- setting the lower sixteen bits of ``eax`` to ``0xffff``
> +- not modifying ``eax`` at all
> +- setting the carry flag
> +
> +SMM command codes
> +-----------------
> +
> +=============== ======================= ================================================
> +Command Code    Command Name            Description
> +=============== ======================= ================================================
> +``0x0025``      Get Fn key status       Returns the Fn key pressed after SMM:
> +
> +                                        - 9th bit in ``eax`` indicates Volume up
> +                                        - 10th bit in ``eax`` indicates Volume down
> +                                        - both bits indicate Volume mute
> +
> +``0xa069``      Get power status        Returns current power status after SMM:
> +
> +                                        - 1st bit in ``eax`` indicates Battery connected
> +                                        - 3th bit in ``eax`` indicates AC connected
> +
> +``0x00a3``      Get fan state           Returns current fan state after SMM:
> +
> +                                        - 1st byte in ``eax`` holds the current
> +                                          fan state (0 - 2 or 3)
> +
> +``0x01a3``      Set fan state           Sets the fan speed:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the desired
> +                                          fan state (0 - 2 or 3)
> +
> +``0x02a3``      Get fan speed           Returns the current fan speed in RPM:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 1st word in ``eax`` holds the current
> +                                          fan speed in RPM (after SMM)
> +
> +``0x03a3``      Get fan type            Returns the fan type:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 1st byte in ``eax`` holds the
> +                                          fan type (after SMM):
> +
> +                                          - 5th bit indicates docking fan
> +                                          - 1 indicates Processor fan
> +                                          - 2 indicates Motherboard fan
> +                                          - 3 indicates Video fan
> +                                          - 4 indicates Power supply fan
> +                                          - 5 indicates Chipset fan
> +                                          - 6 indicates other fan type
> +
> +``0x04a3``      Get nominal fan speed   Returns the nominal RPM in each fan state:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the fan state
> +                                          in question (0 - 2 or 3)
> +                                        - 1st word in ``eax`` holds the nominal
> +                                          fan speed in RPM (after SMM)
> +
> +``0x05a3``      Get fan speed tolerance Returns the speed tolerance for each fan state:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the fan state
> +                                          in question (0 - 2 or 3)
> +                                        - 1st byte in ``eax`` returns the speed
> +                                          tolerance
> +
> +``0x10a3``      Get sensor temperature  Returns the measured temperature:
> +
> +                                        - 1st byte in ``ebx`` holds the sensor number
> +                                        - 1st byte in ``eax`` holds the measured
> +                                          temperature (after SMM)
> +
> +``0x11a3``      Get sensor type         Returns the sensor type:
> +
> +                                        - 1st byte in ``ebx`` holds the sensor number
> +                                        - 1st byte in ``eax`` holds the
> +                                          temperature type (after SMM):
> +
> +                                          - 1 indicates CPU sensor
> +                                          - 2 indicates GPU sensor
> +                                          - 3 indicates SODIMM sensor
> +                                          - 4 indicates other sensor type
> +                                          - 5 indicates Ambient sensor
> +                                          - 6 indicates other sensor type
> +
> +``0xfea3``      Get SMM signature       Returns Dell signature if interface
> +                                        is supported (after SMM):
> +
> +                                        - ``eax`` holds 1145651527
> +                                          (0x44494147 or "DIAG")
> +                                        - ``edx`` holds 1145392204
> +                                          (0x44454c4c or "DELL")
> +
> +``0xffa3``      Get SMM signature       Same as ``0xfea3``, check both.
> +=============== ======================= ================================================
> +
> +There are additional commands for enabling (``0x31a3`` or ``0x35a3``) and
> +disabling (``0x30a3`` or ``0x34a3``) automatic fan speed control.
> +The commands are however causing severe sideeffects on many machines, so
> +they are not used by default.
> +
> +On several machines (Inspiron 3505, Precision 490, Vostro 1720, ...), the
> +fans supports a 4th "magic" state, which signals the BIOS that automatic
> +fan control should be enabled for a specific fan.
> +However there are also some machines who do support a 4th regular fan state too,
> +but in case of the "magic" state, the nominal RPM reported for this state is a
> +placeholder value, which however is not always detectable.
> +
> +Firmware Bugs
> +-------------
> +
> +The SMM calls can behave erratic on some machines:
> +
> +======================================================= =================
> +Firmware Bug                                            Affected Machines
> +======================================================= =================
> +Reading of fan states return spurious errors.           Precision 490
> +
> +Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
> +
> +                                                        Studio XPS 8100
> +
> +                                                        Inspiron 580
> +
> +Fan-related SMM calls take too long (about 500ms).      Inspiron 7720
> +
> +                                                        Vostro 3360
> +
> +                                                        XPS 13 9333
> +
> +                                                        XPS 15 L502X
> +======================================================= =================
> +
> +In case you experience similar issues on your Dell machine, please
> +submit a bugreport on bugzilla to we can apply workarounds.
> +
> +Limitations
> +-----------
> +
> +The SMM calls can take too long to execute on some machines, causing
> +short hangs and/or audio glitches.
> +Also the fan state needs to be restored after suspend, as well as
> +the automatic mode settings.
> +When reading a temperature sensor, values above 127 degrees indicate
> +a BIOS read error or a deactivated sensor.
