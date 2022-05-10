Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C45210FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiEJJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiEJJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:37:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536628F7D9;
        Tue, 10 May 2022 02:33:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so25309051ejb.2;
        Tue, 10 May 2022 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAwbEC4wzGeiHM+S/1u+kwGWnI+5JuwTP+pjO73dBAo=;
        b=p6gYd+2SfPJEv/0eDykmObWhP5R0Oa5G8I1HeJXOxDjPZxBVgGLBp0IkNwJNjeUcXW
         blODB5FDbkg/+fyfAbtVb9qRSOSroLyU0jITU5BgN5pqRT4u7PxEZIBiTP6U34hrW04l
         0nXKnk1gmGpO3NJHH0OFIviPjAU0w/05kRcZuZT8FdR5XmO5D4bIYyGyANk6jrMO1yl9
         VyRhMC6jD0AXb21Qsx/fQduAUI0cUS1qKAV1jW5GhSPfYjVLsM/T6bqL9i4Aly2yqABW
         PGRt3HEQX/NjtcruVWo/qtX0BoteejiCfjCmJEGzitVrlPPx3MyNRtPrLU6bn60i/QWl
         VKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAwbEC4wzGeiHM+S/1u+kwGWnI+5JuwTP+pjO73dBAo=;
        b=mFgM+49fybTPJRhPcI+XOXTzgLHxp1xRnFAyfXIBpNYT1EJ7jQPoHU9YKglNFAwR/0
         oR5ANSbmlssze5owcQdhFIQIkO1I8McklpV+nTbTdQPGirvuRwRKy0ym7uXEiJC2cmy8
         nMdpPUuWXOhj2+ZqqoS6KpBmDF0cp55rHn/Cvgaf84Em/u9f7B4/XgEm5nggZ05pPwqW
         SyKy+Clbrz+8geZIGzWG/fm3lazej8WBqGlYZmAdxLtR6gywJXLIgWWO8YWOQz4Oq2Gj
         yOJcehSkASGeP+BquKnxZLpqjz7qaQRGcfAq0f5/WDiXQIFNPhblQosFeyIDw8DPj7Oj
         3vRA==
X-Gm-Message-State: AOAM533PjN0aXhyvIevKusatl2+lj1ccCC9jNw0+7xoOuYNzxLBgkhBh
        3N3Fpgh4g2VnmF7A5WO52P37hDKJk+PDqpDjbfI=
X-Google-Smtp-Source: ABdhPJw/AvobqN/Ev8vcO4HJVN+jByJDjFJCVqMuTZRITKINfAdGiNbO3Wd3t9RvUEupzEZH4eCa6CZu7gTqoRbfB2E=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr18469874ejc.132.1652175236457; Tue, 10
 May 2022 02:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 May 2022 11:33:19 +0200
Message-ID: <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com>
Subject: Re: [PATCH RESEND v11] platform/chrome: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
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

On Tue, May 10, 2022 at 8:44 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
> to the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using the ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.

> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

You can use --cc parameter to `git send-email` instead of putting
these lines in the commit message.

...

> +#define DEV_ATTR(_var, _name)                                  \
> +       static struct device_attribute dev_attr_##_var =        \
> +               __ATTR(_name, 0444, chromeos_first_level_attr_show, NULL);
> +

Why not ATTR_RO()?

...

> +#define GPIO_ATTR_GROUP(_group, _name, _num)                                           \
> +       static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,                \
> +                                                  struct attribute *attr, int n)       \
> +       {                                                                               \
> +               if (_num < chromeos_acpi_gpio_groups)                                   \
> +                       return attr->mode;                                              \

> +               else                                                                    \

Redundant.

> +                       return 0;                                                       \
> +       }                                                                               \
> +       static ssize_t chromeos_attr_show_gpio_##_num(struct device *dev,               \
> +                                                     struct device_attribute *attr,    \
> +                                                     char *buf)                        \
> +       {                                                                               \
> +               char name[ACPI_ATTR_NAME_LEN + 1];                                      \
> +               int ret, num;                                                           \
> +                                                                                       \
> +               ret = parse_attr_name(attr->attr.name, name, &num);                     \
> +               if (ret)                                                                \
> +                       return ret;                                                     \

> +               ret = chromeos_acpi_evaluate_method(dev, _num, num, name, buf);         \
> +               if (ret < 0)                                                            \
> +                       ret = 0;                                                        \

Below I saw the same code, why is the error ignored?

> +               return ret;                                                             \
> +       }                                                                               \
> +       static struct device_attribute dev_attr_0_##_group =                            \
> +               __ATTR(GPIO.0, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_1_##_group =                            \
> +               __ATTR(GPIO.1, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_2_##_group =                            \
> +               __ATTR(GPIO.2, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_3_##_group =                            \
> +               __ATTR(GPIO.3, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +                                                                                       \
> +       static struct attribute *attrs_##_group[] = {                                   \
> +               &dev_attr_0_##_group.attr,                                              \
> +               &dev_attr_1_##_group.attr,                                              \
> +               &dev_attr_2_##_group.attr,                                              \
> +               &dev_attr_3_##_group.attr,                                              \
> +               NULL                                                                    \
> +       };                                                                              \
> +       static const struct attribute_group attr_group_##_group = {                     \
> +               .name = _name,                                                          \
> +               .is_visible = attr_is_visible_gpio_##_num,                              \

> +               .attrs = attrs_##_group                                                 \

Keep a comma here.

> +       };

> +               // select sub element inside this package

Seems you have different comment styles over the same file. Please,
use /* ... */ here which seems what you wanted.

...

> +static int parse_attr_name(const char *name, char *attr_name, int *attr_num)
> +{
> +       int ret = 0;
> +
> +       strscpy(attr_name, name, ACPI_ATTR_NAME_LEN + 1);
> +
> +       if (strlen(name) > ACPI_ATTR_NAME_LEN)

This seems strange, esp. taking into account that strscpy() returns that.

int ret;

ret = strscpy(...);
if (ret == -E2BIG)
  return kstrtoint(...);

return 0;

> +               ret = kstrtoint(&name[ACPI_ATTR_NAME_LEN + 1], 0, attr_num);
> +
> +       return ret;
> +}

...

> +static ssize_t chromeos_first_level_attr_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf)
> +{
> +       char attr_name[ACPI_ATTR_NAME_LEN + 1];
> +       int ret, attr_num = 0;
> +
> +       ret = parse_attr_name(attr->attr.name, attr_name, &attr_num);
> +       if (ret)
> +               return 0;

> +       ret = chromeos_acpi_evaluate_method(dev, attr_num, 0, attr_name, buf);
> +       if (ret < 0)
> +               ret = 0;

Why is the error not reported?

> +       return ret;
> +}

...

> +static unsigned int get_gpio_pkg_num(struct device *dev)
> +{
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +       acpi_status status;
> +       unsigned int count = 0;
> +       char *name = "GPIO";
> +
> +       status = acpi_evaluate_object(ACPI_HANDLE(dev), name, NULL, &output);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to retrieve %s. %s\n", name, acpi_format_exception(status));
> +               return count;
> +       }
> +
> +       if (((union acpi_object *)output.pointer)->type == ACPI_TYPE_PACKAGE)
> +               count = ((union acpi_object *)output.pointer)->package.count;

Instead of doing ugly castings here, just use a temporary variable of
the correct type.

> +       kfree(output.pointer);
> +       return count;
> +}

...

> +/* Every platform can have different number of GPIO attribute groups.

a different

> + * Define upper limit groups. At run time, the platform decides to show
> + * the present number of groups only, others are hidden.
> + */

Comment style, see below.

...

> +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> +{
> +       chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);

> +       /* If platform has more GPIO attribute groups than the number of

If the platform

> +        * groups this driver supports, give out a warning message.
> +        */

/*
 * This style is for network subsystem, we use
 * this one.
 */

> +       if (chromeos_acpi_gpio_groups > (ARRAY_SIZE(chromeos_acpi_all_groups) - 2))
> +               dev_warn(&(pdev->dev), "Only %u GPIO attr groups supported by the driver out of total %u.\n",

In both lines too many parentheses.

> +                        (unsigned int)(ARRAY_SIZE(chromeos_acpi_all_groups) - 2),

Oh la la, instead of doing ugly castings, use proper specifiers, i.e. %zu.

> +                        chromeos_acpi_gpio_groups);
> +       return 0;
> +}

...

> +static struct platform_driver chromeos_acpi_device_driver = {
> +       .probe = chromeos_acpi_device_probe,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .dev_groups = chromeos_acpi_all_groups,

> +               .acpi_match_table = ACPI_PTR(chromeos_device_ids)

ACPI_PTR in most cases is not only useless, but might give a compiler warning.

> +       }
> +};

--
With Best Regards,
Andy Shevchenko
