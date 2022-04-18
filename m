Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A95505F13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiDRVDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDRVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:03:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943729CA5;
        Mon, 18 Apr 2022 14:00:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g13so1303643ejb.4;
        Mon, 18 Apr 2022 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s49MuJS7EtIm1BiU8ytUtIRhfv4IUVLxSmWXxvR9Bsg=;
        b=e2kdszhFrvCaUrpm5fDjIoLI0C0X7JLgr2s0XZdTOSd84ExJSQSEmp3wOoOOcCT8tS
         qwTWDGthc8Zv0iu5WYlUyBXBvBhhPR0sKOYVD/6ekJzVz6jbqSlIxoeqKGcMvOex06g+
         xA90QhlyTVAv/J+7ptubmRbhS4yfk+e1mRgfcP5ay2PoyMjaqR2CiRUfrbjQZpSo2spu
         6mzViQCKgOZjYIbna5ZWSMnmPOfYADCRnzF9BPPxPUJL14rRI9zOkgs7KAP/61IkaWPp
         /Y9aQf5dbIT7/L8gVTdR6NESZyW48hwJ87+y4La5ROQOaGH+UMqKqA/KUaElm8tAfOCM
         gefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s49MuJS7EtIm1BiU8ytUtIRhfv4IUVLxSmWXxvR9Bsg=;
        b=LBXAbIRtYKY8jG3LnjW3DMe894dGz809600zbmMuVDmWoXhXhj526AUVNzYAenAAgF
         yJoX1YQ21cSRerI4mdvL9WfWiVaZ0iT0wxM2RpyyECoIHlv9E03sUK1jQuihQaEVutHH
         jujseSjsZYqT33TT65u7G6ThVpJvXeSvdnk6Wrsb9HAvCCPQ3nnCzv7/Kxf8pVxd2wTw
         iXxL3lKiuRn853ThKkGc+g7n/Is//zLOrmbMfLUS+Dc6QEBShNfd3SrMKQma72I+95q2
         PawST5pmlfEim9AIxFhrsjmk3u+Wv9NFJwTDdHB1iV4WB2uw8TExR5obkkatdg3r7PDa
         rWTA==
X-Gm-Message-State: AOAM531sy2/+43YgC2MZy+4xR/ExPiWv8Hpm43DOcSQ8zp4oMOBZcljo
        153yJeWNA71wsyFZdqkrSyLSolvRT6gdHue/XvfRMzJ0b6srOq2b
X-Google-Smtp-Source: ABdhPJyVa+tqzJ31xec8CMDzMFN/KxOGV0GSwFA/L+QTb4k3i/EZzvz5/Smdj2a5SA1IPi+9C5HfMIO+DVteR+nNHuM=
X-Received: by 2002:a17:907:8a14:b0:6e8:9691:62f7 with SMTP id
 sc20-20020a1709078a1400b006e8969162f7mr10815351ejc.497.1650315654172; Mon, 18
 Apr 2022 14:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Apr 2022 00:00:17 +0300
Message-ID: <CAHp75VeahcM4jwQ_+65JOgqrDXHVrZvdpj8UaGVakJP0gFmZvQ@mail.gmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 8:08 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to

Either 'devices' or ' the ChromeOS'.

> the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using ACPI component of the kernel. The ACPI values

'the ACPI'

> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.

...

> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

No need to have in the commit message, esp. taking into account below tag.

> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> Cc: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Missed Co-developed-by?

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

...

> +What:          /sys/bus/platform/devices/GGL0001:00/VBNV.1

In all these examples theoretically the second part can be :01 or
anything depending on how many devices of the kind the platform has
(note, that may be the case when in the ACPI tables the first device,
for example, simply has status not 15, like in multi-platform DSDT
when it's done at boot-time).

...

> +Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
> +The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is valid PNP ID of Google.

a valid

> +PNP ID can be used with the ACPI devices accourding to the guidelines. The following ACPI

according

> +objects are supported:

...

> +   * - 0x00000200
> +     - Firmware write protect was disabled when x86 firmware booted. (required if

protection

> +       firmware write protect is controlled through x86 BIOS; otherwise optional)

protection

...

> +MECK (Management Engine Checksum)
> +=================================
> +This control method returns the SHA-1 or SHA-256 hash that is read out of the Management
> +Engine extend registers during boot. The hash is exported via ACPI so the OS can verify that

extended ?

> +the ME firmware has not changed. If Management Engine is not present, or if the firmware was
> +unable to read the extend registers, this buffer can be zero.

Ditto.

...

> +static char *chromeos_acpi_default_methods[] = {
> +       "CHSW", "HWID", "BINF", "GPIO", "CHNV", "FWID", "FRID", MLST

You can still leave comma at the end.

> +};

...

> +static char *chromeos_acpi_gen_file_name(char *name, int count, int index)
> +{
> +       char *str;

You can avoid it, by returning directly.

> +       if (count == 1)
> +               str = kstrdup(name, GFP_KERNEL);
> +       else
> +               str = kasprintf(GFP_KERNEL, "%s.%d", name, index);
> +
> +       return str;
> +}

...

> +       switch (element->type) {
> +       case ACPI_TYPE_BUFFER:
> +               length = element->buffer.length;
> +               info->data = kmemdup(element->buffer.pointer,
> +                                    length, GFP_KERNEL);
> +               break;
> +       case ACPI_TYPE_INTEGER:

> +               length = snprintf(buffer, sizeof(buffer), "%d",
> +                                 (int)element->integer.value);
> +               info->data = kmemdup(buffer, length, GFP_KERNEL);

kasprintf()

> +               break;
> +       case ACPI_TYPE_STRING:
> +               length = element->string.length + 1;
> +               info->data = kstrdup(element->string.pointer, GFP_KERNEL);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               goto free_attr_name;
> +       }

> +       if (!info->data) {
> +               ret = -ENOMEM;
> +               goto free_attr_name;
> +       }

While saving a few lines of code this is more fragile to have it after
the switch, because it might be in the future that some of those types
won't fill info->data and be correct. But I have no strong opinion
here.

...

> +                       if (ret) {
> +                               dev_err(dev, "error adding attributes (%d)\n",
> +                                       ret);
> +                               return ret;
> +                       }

> +                       if (ret) {
> +                               dev_err(dev, "error adding a group (%d)\n",
> +                                       ret);
> +                               return ret;
> +                       }

> +                       if (ret) {
> +                               dev_err(dev, "error on element type (%d)\n",
> +                                       ret);
> +                               return -EINVAL;
> +                       }

I believe all three can be converted to return dev_error_probe(...);

...

> +static int chromeos_acpi_add_method(struct platform_device *pdev, char *name)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +       acpi_status status;
> +       int ret = 0;
> +
> +       status = acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, name, NULL, &output);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to retrieve %s (%d)\n", name, status);
> +               return status;

Are you sure it's valid error code returned here?

> +       }
> +
> +       if (((union acpi_object *)output.pointer)->type == ACPI_TYPE_PACKAGE)
> +               ret = chromeos_acpi_handle_package(pdev, output.pointer, name);
> +
> +       kfree(output.pointer);
> +       return ret;
> +}
> +

...

> +       status = acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, MLST, NULL,
> +                                     &output);
> +       if (ACPI_FAILURE(status))
> +               return status;

Are you sure it's correct error code returned here?

> +       obj = output.pointer;
> +       if (obj->type != ACPI_TYPE_PACKAGE) {
> +               ret = -EINVAL;
> +               goto free_acpi_buffer;
> +       }

...

> +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> +{
> +       struct chromeos_acpi_attribute_group *aag;
> +       struct device *dev = &pdev->dev;
> +       int i, ret;
> +
> +       aag = kzalloc(sizeof(*aag), GFP_KERNEL);

devm_kzalloc() ?

> +       if (!aag)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&aag->attribs);
> +       INIT_LIST_HEAD(&aag->list);
> +       INIT_LIST_HEAD(&chromeos_acpi.groups);
> +
> +       chromeos_acpi.root = aag;
> +
> +       /*
> +        * Attempt to add methods by querying the device's MLST method
> +        * for the list of methods.
> +        */
> +       if (!chromeos_acpi_process_mlst(pdev))
> +               return 0;
> +
> +       dev_dbg(dev, "falling back to default list of methods\n");
> +
> +       for (i = 0; i < ARRAY_SIZE(chromeos_acpi_default_methods); i++) {
> +               ret = chromeos_acpi_add_method(pdev,
> +                                              chromeos_acpi_default_methods[i]);
> +               if (ret) {
> +                       dev_err(dev, "failed to add default methods (%d)\n",
> +                               ret);
> +                       goto free_group_root;

return dev_err_probe(...); ?

> +               }
> +       }
> +
> +       return 0;
> +
> +free_group_root:
> +       kfree(chromeos_acpi.root);
> +       return ret;
> +}
> +
> +static int chromeos_acpi_device_remove(struct platform_device *pdev)
> +{
> +       /* Remove sysfs groups */
> +       sysfs_remove_groups(&pdev->dev.kobj, chromeos_acpi.dev_groups);
> +       kfree(chromeos_acpi.dev_groups);
> +
> +       /* Remove allocated chromeos acpi groups and attributes */
> +       chromeos_acpi_remove_groups();

I'm wondering why you have no such things in error path of the ->probe().

> +       return 0;
> +}

...

> +static struct platform_driver chromeos_acpi_device_driver = {
> +       .probe = chromeos_acpi_device_probe,
> +       .remove = chromeos_acpi_device_remove,
> +       .driver = {
> +               .name   = "chromeos-acpi",

> +               .acpi_match_table = ACPI_PTR(chromeos_device_ids)

The point of usage of ACPI_PTR is...?

> +       }
> +};

> +

No need to have this blank line.

> +module_platform_driver(chromeos_acpi_device_driver);

-- 
With Best Regards,
Andy Shevchenko
